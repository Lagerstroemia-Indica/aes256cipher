import Flutter
import UIKit

public class AES256CipherPlugin: NSObject, FlutterPlugin {
    let errorMessage = "BAD_DECRYPT: Please check again your 'aesKey'"
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
        let encryptedData: String = self.encrypt(args: call.arguments as! [String: Any])
        result(encryptedData)
      break
    case AES256CipherConstant.decrypt:
        let decryptedData: String = self.decrypt(args: call.arguments as! [String: Any])
        result(decryptedData)
      break
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
