import Flutter
import UIKit

public class AES256CipherPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "aes256cipher", binaryMessenger: registrar.messenger())
    // This name change yaml files plugin name.
    let aes256CipherInstance = AES256CipherPlugin()
    registrar.addMethodCallDelegate(aes256CipherInstance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case AES256CipherConstant.version:
      result("iOS " + UIDevice.current.systemVersion)
      break
    case AES256CipherConstant.encrypt:
      result("please encrypt!")
      break
    case AES256CipherConstant.decrypt:
      result("please decrypt!")
      break
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
