/*
 * Copyright (C) 2015 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


#define LOG_TAG "meizuLights"

#include <cutils/log.h>
#include <cutils/properties.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <hardware/lights.h>

static pthread_once_t g_init = PTHREAD_ONCE_INIT;
static pthread_mutex_t g_lock = PTHREAD_MUTEX_INITIALIZER;
static struct light_state_t g_battery;
static struct light_state_t g_notification;
static struct light_state_t g_attention;

//
// Needed LED class directories and files
//
#define LEDS       "/sys/class/leds/"
#define NOTIFIER   "mx-led/"
#define LCD        "lcd-backlight/"
#define BRIGHTNESS "brightness"
#define BLINK      "blink"

void init_globals(void) {
    pthread_mutex_init(&g_lock, NULL);
    memset(&g_battery, 0, sizeof(g_battery));
    memset(&g_notification, 0, sizeof(g_notification));
}

static int write_string(const char *path, const char *buffer) {
    int fd;
    static int already_warned = 0;

    fd = open(path, O_RDWR);
    if (fd >= 0) {
        int bytes = strlen(buffer);
        int amt = write(fd, buffer, bytes);
        close(fd);
        return amt == -1 ? -errno : 0;
    } else {
        if (already_warned == 0) {
            ALOGE("write_string failed to open %s (%s)\n", path, strerror(errno));
            already_warned = 1;
        }
        return -errno;
    }
}

static int write_int(const char *path, int value) {
    char buffer[20];
    sprintf(buffer, "%d\n", value);
    return write_string(path, buffer);
}

static int is_lit(struct light_state_t const* state) {
    return state->color & 0x00ffffff;
}

static int rgb_to_brightness(const struct light_state_t *state) {
    int color = state->color & 0x00ffffff;
    return ((77*((color>>16)&0x00ff))
            + (150*((color>>8)&0x00ff)) + (29*(color&0x00ff))) >> 8;
}

static int set_light_backlight(struct light_device_t* dev,
        struct light_state_t const* state) {
    int ret = 0;
    int brightness = rgb_to_brightness(state);

    pthread_mutex_lock(&g_lock);
    ret = write_int(LEDS LCD BRIGHTNESS, brightness);
    pthread_mutex_unlock(&g_lock);

    return ret;
}

static int notification_led_control(struct light_state_t const *state)
{
    int ret = 0;
    int onMS, offMS;

    if (state == NULL) {
        return -EINVAL;
    }

    switch (state->flashMode) {
    case LIGHT_FLASH_TIMED:
        onMS = state->flashOnMS;
        offMS = state->flashOffMS;
        break;
    case LIGHT_FLASH_NONE:
    default:
        onMS = 0;
        offMS = 0;
        break;
    }

    if (onMS > 0 && offMS > 0) {
				// We have white LED, so just enable blinking.
				ret = write_int(LEDS NOTIFIER BLINK, 1);
    } else if (!rgb_to_brightness(state)) {
        ret = write_int(LEDS NOTIFIER BLINK, 0);
        if (ret)
            return ret;
        ret = write_int(LEDS NOTIFIER BRIGHTNESS, 0);
    } else {
        ret = write_int(LEDS NOTIFIER BRIGHTNESS, rgb_to_brightness(state));
    }
    return ret;
}


static int handle_led_control(void) {
    int ret = 0;

    // Disable LED before operating with it.
    write_int(LEDS NOTIFIER BLINK, 0);
    write_int(LEDS NOTIFIER BRIGHTNESS, 0);

    if (is_lit(&g_attention)) {
			ret = notification_led_control(&g_attention);
    } else if (is_lit(&g_notification)) {
			ret = notification_led_control(&g_notification);
    } else {
			ret = notification_led_control(&g_battery);
    }

    return ret;
}

static int set_light_battery(struct light_device_t* dev,
        struct light_state_t const* state) {
    pthread_mutex_lock(&g_lock);

    g_battery = *state;
    handle_led_control();
    pthread_mutex_unlock(&g_lock);

    return 0;
}

static int set_light_notification(struct light_device_t* dev,
        struct light_state_t const* state) {
    pthread_mutex_lock(&g_lock);
    g_notification = *state;
    handle_led_control();
    pthread_mutex_unlock(&g_lock);

    return 0;
}

static int set_light_attention(struct light_device_t* dev,
        struct light_state_t const* state) {
    pthread_mutex_lock(&g_lock);

    g_attention = *state;
    if (state->flashMode == LIGHT_FLASH_HARDWARE) {
        if (g_attention.flashOnMS > 0 && g_attention.flashOffMS == 0) {
            g_attention.flashMode = LIGHT_FLASH_NONE;
        }
    } else if (state->flashMode == LIGHT_FLASH_NONE) {
        g_attention.color = 0;
    }
    notification_led_control(state);

    pthread_mutex_unlock(&g_lock);

    return 0;
}

static int close_lights(struct light_device_t *dev) {
    if (dev) {
        free(dev);
    }
    return 0;
}

static int open_lights(const struct hw_module_t* module, char const* name,
        struct hw_device_t** device) {
    int (*set_light)(struct light_device_t* dev,
            struct light_state_t const* state);

    if (0 == strcmp(LIGHT_ID_BACKLIGHT, name)) {
			set_light = set_light_backlight;
    } else if (0 == strcmp(LIGHT_ID_BATTERY, name)) {
			set_light = set_light_battery;
    } else if (0 == strcmp(LIGHT_ID_NOTIFICATIONS, name)) {
			set_light = set_light_notification;
    } else if (0 == strcmp(LIGHT_ID_ATTENTION, name)) {
			set_light = set_light_attention;
    } else {
        ALOGE("%s: unknown led id %s", __FUNCTION__, name);
        return -EINVAL;
    }

    pthread_once(&g_init, init_globals);

    struct light_device_t *dev = malloc(sizeof(struct light_device_t));
    memset(dev, 0, sizeof(*dev));

    dev->common.tag = HARDWARE_DEVICE_TAG;
    dev->common.version = 0;
    dev->common.module = (struct hw_module_t*)module;
    dev->common.close = (int (*)(struct hw_device_t*))close_lights;
    dev->set_light = set_light;

    *device = (struct hw_device_t*)dev;
    return 0;
}


static struct hw_module_methods_t lights_module_methods = {
    .open =  open_lights,
};

struct hw_module_t HAL_MODULE_INFO_SYM = {
    .tag = HARDWARE_MODULE_TAG,
    .version_major = 1,
    .version_minor = 0,
    .id = LIGHTS_HARDWARE_MODULE_ID,
    .name = "Meizu M6 note lights Module",
    .author = "tdrkDev",
    .methods = &lights_module_methods,
};
