/*
 * Copyright (C) 2021 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

package org.lineageos.settings.mback;
import android.content.Context;
import android.util.Log;
import android.view.KeyEvent;
import android.os.Vibrator;
import android.os.VibrationEffect;
import android.app.Fragment;
import android.app.Activity;
import android.provider.Settings;
import org.lineageos.settings.mback.MBackSettings;
import org.lineageos.settings.preferences.FileUtils;

import java.io.FileNotFoundException;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;

import com.android.internal.os.DeviceKeyHandler;

public class KeyHandler implements DeviceKeyHandler {
    private static final String TAG = "KeyHandler";
    private static final String GOODIX_PATH = "/proc/gf_vibration";
    private Context mContext;
    private Vibrator mVibrator;

    public static int getData() {
        String line = FileUtils.readOneLine(GOODIX_PATH);
        if (line == null) {
            Log.e(TAG, "Failed to read Goodix file");
            return 0;
        }

        return Integer.parseInt(line);
    }

    public static void setData(int data) {
        FileUtils.setValue(GOODIX_PATH, data);
    }

    private void mBackVibrate() {
        int duration = getData();
        if (duration == 0) {
            Log.i(TAG, "mBack vibration is disabled");
            return;
        }

        if (mVibrator != null)
            mVibrator.vibrate(VibrationEffect.createOneShot(duration, VibrationEffect.DEFAULT_AMPLITUDE));
        else
            Log.e(TAG, "mVibrator is null");
    }

    public void setDuration(int d, boolean vibrate) {
        setData(d);

        // Vibrate if user has changed value
        if (vibrate)
            mBackVibrate();
    }

    public KeyEvent handleKeyEvent(KeyEvent event) {
        if (event.getScanCode() == 158 && event.getAction() == KeyEvent.ACTION_DOWN)
            mBackVibrate();

        return event;
    }

    public KeyHandler(Context context) {
        mVibrator = context.getSystemService(Vibrator.class);
        mContext = context;
    }
}
