package com.hax.qasdvcmsp;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

public class PlaceholderReceiver extends BroadcastReceiver {
    @Override
    public void onReceive(final Context context, Intent intent) {
        Log.i("HAX_QAS_DVC_MSP", "triggered");
    }
}