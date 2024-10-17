package com.donguran.aes256cipher

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.*

/** Aes256cipherPlugin */
class AES256CipherPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "aes256cipher")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
      Constant.encrypt -> {
        CoroutineScope(Dispatchers.IO).launch {
          val encryptResult: String? = async {
            val params = (call.arguments as? Map<* ,*>)?.entries
              ?.associate { element -> element.key.toString() to element.value }
              ?.toMutableMap()
            AES256Cipher.encrypt(params = params!!)
          }.await()

          result.success(encryptResult)
        }
      }

      Constant.decrypt -> {
        CoroutineScope(Dispatchers.IO).launch {
          val encryptResult: String? = async {
            val params = (call.arguments as? Map<* ,*>)?.entries
              ?.associate { element -> element.key.toString() to element.value }
              ?.toMutableMap()
            AES256Cipher.decrypt(params = params!!)
          }.await()

          result.success(encryptResult)
        }
      }

      else -> result.notImplemented()
    }

    /*if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else {
      result.notImplemented()
    }*/
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
