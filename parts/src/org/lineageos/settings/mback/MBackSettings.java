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
import android.os.Bundle;
import android.os.Handler;
import android.provider.Settings;
import android.util.Log;
import androidx.preference.Preference;
import androidx.preference.PreferenceCategory;
import androidx.preference.PreferenceFragment;
import androidx.preference.ListPreference;
import org.lineageos.settings.R;
import org.lineageos.settings.preferences.FileUtils;
import org.lineageos.settings.mback.KeyHandler;

public class MBackSettings extends PreferenceFragment 
                           implements Preference.OnPreferenceChangeListener {
    public static final String KEY_VIBRO_STRENGTH = "mback_vibration_strength";
    private static final String GOODIX_PATH = "/proc/gf_vibration";
    private Preference mStrengthPreference;

    private String getVibrationMode() {
        String modes[] = getResources().getStringArray(org.lineageos.settings.R.array.vibration_strength_entries);

        switch (KeyHandler.getData()) {
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
        mStrengthPreference.setEnabled(FileUtils.fileWritable(GOODIX_PATH));
        mStrengthPreference.setOnPreferenceChangeListener(this);

        if (FileUtils.fileWritable(GOODIX_PATH))
            mStrengthPreference.setSummary(getVibrationMode());
    }

    @Override
    public boolean onPreferenceChange(Preference preference, Object value) {
        (new KeyHandler(getContext())).setDuration(Integer.parseInt((String) value), true);

        // Save new value
        Settings.Secure.putInt(getContext().getContentResolver(), 
                               KEY_VIBRO_STRENGTH, Integer.parseInt((String) value));
        mStrengthPreference.setSummary(getVibrationMode());
        return true;
    }
}
