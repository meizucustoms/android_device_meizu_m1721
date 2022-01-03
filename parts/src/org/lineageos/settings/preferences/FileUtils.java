/*
 * Copyright (C) 2016 The CyanogenMod Project
 * Copyright (C) 2018 The Asus-SDM660 Project
 * Copyright (C) 2017-2021 The LineageOS Project
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
 * limitations under the License
 */

package org.lineageos.settings.preferences;

import android.util.Log;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.FileNotFoundException;
import java.io.FileInputStream;
import java.io.BufferedReader;
import java.io.FileReader;
import java.nio.charset.StandardCharsets;

public final class FileUtils {
    private static final String TAG = "FileUtils";

    public static boolean fileWritable(String filename) {
        return fileExists(filename) && new File(filename).canWrite();
    }

    public static boolean fileExists(String filename) {
        if (filename == null) {
            return false;
        }
        return new File(filename).exists();
    }

    public static void setValue(String path, int value) {
        if (fileWritable(path)) {
            if (path == null) {
                return;
            }
            try {
                FileOutputStream fos = new FileOutputStream(new File(path));
                fos.write(Integer.toString(value).getBytes());
                fos.flush();
                fos.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public static void setValue(String path, double value) {
        if (fileWritable(path)) {
            if (path == null) {
                return;
            }
            try {
                FileOutputStream fos = new FileOutputStream(new File(path));
                fos.write(Long.toString(Math.round(value)).getBytes());
                fos.flush();
                fos.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public static void setValue(String path, String value) {
        if (fileWritable(path)) {
            if (path == null) {
                return;
            }
            try {
                FileOutputStream fos = new FileOutputStream(new File(path));
                fos.write(value.getBytes());
                fos.flush();
                fos.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public static String readOneLine(String fileName) {
        String line = null;
        BufferedReader reader = null;

        try {
            reader = new BufferedReader(new FileReader(fileName), 512);
            line = reader.readLine();
        } catch (FileNotFoundException e) {
            Log.w(TAG, "No such file " + fileName + " for reading", e);
        } catch (IOException e) {
            Log.e(TAG, "Could not read from file " + fileName, e);
        } finally {
            try {
                if (reader != null) {
                    reader.close();
                }
            } catch (IOException e) {
                // Ignored, not much we can do anyway
            }
        }

        return line;
    }
}
