package br.com.gok.curso.flutter_app_true_history

import android.annotation.SuppressLint
import android.net.wifi.WifiManager
import android.os.Bundle
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {

    private val CHANNEL = "app/networkdata"

    private lateinit var wifiManager: WifiManager

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        wifiManager = getApplicationContext().getSystemService(WIFI_SERVICE) as WifiManager
    }

    @SuppressLint("MissingPermission", "NewApi")
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        //uma esposta a uma chamada que partiu do código DART
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            val connectionInfo = wifiManager.connectionInfo
            result.success("${connectionInfo.macAddress}|${connectionInfo.rssi}")
        }
    }

}
