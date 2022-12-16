package com.dchainconnect.bookrabbit

import android.content.ActivityNotFoundException
import android.content.Intent
import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.net.URISyntaxException


class MainActivity: FlutterActivity() {
    private val CHANNEL = "default_channel"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        GeneratedPluginRegistrant.registerWith(flutterEngine!!)
        MethodChannel(getBinaryMessenger(), CHANNEL).setMethodCallHandler { call, result ->
            // Note: this method is invoked on the main thread.
            when (call.method) {
                "getAppUrl" -> getAppUrl(call, result)
            }

        }
    }

    fun getFlutterView(): BinaryMessenger {
        return flutterEngine!!.dartExecutor.binaryMessenger
    }

    private fun getBinaryMessenger(): BinaryMessenger {
        return flutterEngine!!.dartExecutor.binaryMessenger
    }

    private fun getAppUrl(call: MethodCall, result: MethodChannel.Result) {
        try {
            val url: String? = call.argument("url")
            Log.i("url", url.toString())
            val intent = Intent.parseUri(url, Intent.URI_INTENT_SCHEME)
            result.success(intent.dataString)
        } catch (e: URISyntaxException) {
            result.notImplemented()
        } catch (e: ActivityNotFoundException) {
            result.notImplemented()
        }
    }
}
