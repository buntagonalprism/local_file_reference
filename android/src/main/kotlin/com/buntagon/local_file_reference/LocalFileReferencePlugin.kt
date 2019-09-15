package com.buntagon.local_file_reference

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.io.File

class LocalFileReferencePlugin: MethodCallHandler {
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "com.buntagon/local_file_reference")
      channel.setMethodCallHandler(LocalFileReferencePlugin())
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getData") {
      val path: String? = call.argument("path")
      val file = File(path)
      result.success(file.readBytes())
    } else {
      result.notImplemented()
    }
  }
}
