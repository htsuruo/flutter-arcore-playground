package com.htsuruo.flutter_unity_widget_ex

import io.flutter.embedding.android.FlutterActivity
import com.xraph.plugin.flutter_unity_widget.IFlutterUnityActivity;

class MainActivity: FlutterActivity(), IFlutterUnityActivity {
    // unity needs this mUnityPlayer property
    @JvmField
    var mUnityPlayer: java.lang.Object? = null;

    // implement this function so the FUW plugin can set mUnityPlayer
    override fun setUnityPlayer(unityPlayer: java.lang.Object?) {
        mUnityPlayer = unityPlayer;
    }
}
