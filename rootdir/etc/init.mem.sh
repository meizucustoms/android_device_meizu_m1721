#!/vendor/bin/sh
#
# Copyright (C) 2022 Paranoid Android
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set_read_ahead() {
    echo "$1" > /sys/class/block/mmcblk0/queue/read_ahead_kb
}

set_scheduler() {
    setprop persist.sys.io.scheduler "$1"
    echo "$1" > /sys/class/block/mmcblk0/queue/scheduler
}

get_emmc_size() {
    blocks=$(cat /sys/class/block/mmcblk0/size)
    bytes=$(expr $blocks \* 512)
    echo "$(expr $bytes / 1024 / 1024 / 1024)"
}

set_dirty_ratio() {
    echo "$1" > /proc/sys/vm/dirty_ratio
}

set_dirty_bg_ratio() {
    echo "$1" > /proc/sys/vm/dirty_background_ratio
}

set_dirty_expire_centisecs() {
    echo "$1" > /proc/sys/vm/dirty_expire_centisecs
}

set_dirty_writeback_centisecs() {
    echo "$1" > /proc/sys/vm/dirty_writeback_centisecs
}

if [ "$(get_emmc_size)" -gt 32 ]; then
    set_read_ahead 3072
elif [ "$(get_emmc_size)" -gt 16 ]; then
    set_read_ahead 2048
else
    set_read_ahead 1024
fi

set_scheduler noop
set_dirty_ratio 99
set_dirty_bg_ratio 50
set_dirty_expire_centisecs 60000
set_dirty_writeback_centisecs 60000
