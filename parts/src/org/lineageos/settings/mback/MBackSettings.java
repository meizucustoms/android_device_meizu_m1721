/*
 * Copyright (C) 2015 The CyanogenMod Project
 *               2022 The LineageOS Project
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

package org.lineageos.settings.mback;

import android.content.Intent;
import android.content.Context;
import android.os.Bundle;
import android.os.Handler;
import android.os.Vibrator;
import android.os.VibrationEffect;
import android.provider.Settings;
import android.util.Log;
import android.media.AudioManager;
import androidx.preference.Preference;
import androidx.preference.PreferenceCategory;
import androidx.preference.PreferenceFragment;
import androidx.preference.ListPreference;
import org.lineageos.settings.R;
import org.lineageos.settings.preferences.CustomSeekBarPreference;
import org.lineageos.settings.preferences.FileUtils;
import org.lineageos.settings.mback.KeyHandler;

import java.lang.Math;

public class MBackSettings extends PreferenceFragment 
                           implements Preference.OnPreferenceChangeListener {
    public static final String KEY_VIBRO_STRENGTH = "mback_vibration_strength";
    public static final String KEY_TOUCH_SOUND = "mback_touch_sound_volume";
    private Preference mStrengthPreference;
    private CustomSeekBarPreference mVolumePreference;

    private String getVibrationMode() {
        String modes[] = getResources().getStringArray(org.lineageos.settings.R.array.vibration_strength_entries);

        switch (Settings.Secure.getInt(getContext().getContentResolver(), KEY_VIBRO_STRENGTH, 110)) {
            case 110:
                return modes[3];
            case 90:
                return modes[2];
            case 70:
                return modes[1];
        }

        return modes[0];
    }

    @Override
    public void onCreatePreferences(Bundle savedInstanceState, String rootKey) {
        setPreferencesFromResource(R.xml.mback_settings, rootKey);
        mStrengthPreference = (ListPreference) findPreference(KEY_VIBRO_STRENGTH);
        mStrengthPreference.setEnabled(true);
        mStrengthPreference.setOnPreferenceChangeListener(this);
        mStrengthPreference.setSummary(getVibrationMode());

        mVolumePreference = (CustomSeekBarPreference) findPreference(KEY_TOUCH_SOUND);
        mVolumePreference.setEnabled(true);
        mVolumePreference.setOnPreferenceChangeListener(this);
        mVolumePreference.setMax(
            ((AudioManager) getContext().getSystemService(Context.AUDIO_SERVICE)).getStreamMaxVolume(AudioManager.STREAM_MUSIC));
        mVolumePreference.setValue(Settings.Secure.getInt(getContext().getContentResolver(), 
                                                          MBackSettings.KEY_TOUCH_SOUND, 10));
    }

    @Override
    public boolean onPreferenceChange(Preference preference, Object value) {
        switch (preference.getKey()) {
        case KEY_VIBRO_STRENGTH:
            int val = Integer.parseInt((String) value);
            Settings.Secure.putInt(getContext().getContentResolver(), KEY_VIBRO_STRENGTH, val);
            
            Vibrator v = getContext().getSystemService(Vibrator.class);
            if (val > 0)
                v.vibrate(VibrationEffect.createOneShot(val, VibrationEffect.DEFAULT_AMPLITUDE));

            mStrengthPreference.setSummary(getVibrationMode());
            break;

        case KEY_TOUCH_SOUND:
            Settings.Secure.putInt(getContext().getContentResolver(), 
                                   KEY_TOUCH_SOUND, (int) value);
            mVolumePreference.setValue((int) value);
            break;
        }
        
        return true;
    }
}
