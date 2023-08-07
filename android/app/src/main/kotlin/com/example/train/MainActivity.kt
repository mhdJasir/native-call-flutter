package com.example.train

import android.widget.Toast
import com.google.gson.Gson
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject

class MainActivity : FlutterFragmentActivity() {
    private val channel = "flutter.native/helper"

    private lateinit var methodChannel: MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger, channel
        ).setMethodCallHandler { call, result ->
            methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel)
            when {
                call.method.equals("auth") -> {
                    val map = call.arguments as HashMap<*, *>
                    val json = JSONObject(map).toString()
                    val gson = Gson()
                    val authInputs =
                        gson.fromJson(json, AuthModel::class.java)
                    AuthActivity(applicationContext).authenticate(methodChannel, this, authInputs)
                }
                call.method.equals("canAuthenticate") -> {
                    val canAuthenticate =
                        AuthActivity(applicationContext).canAuthenticate()
                    methodChannel.invokeMethod("canAuthenticate", canAuthenticate.toString())
                    result.success(canAuthenticate.toString())
                }
                call.method.equals("showToast") -> {
                    val text: String? = call.argument("text")
                    val length: Int? = call.argument("length")
                    Toast.makeText(
                        applicationContext, text, length ?: 0,
                    ).show()
                }
            }
        }
    }
}

