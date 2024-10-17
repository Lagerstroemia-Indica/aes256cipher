import 'package:aes256cipher/src/aes256cipher_const.dart';
import 'package:flutter/services.dart';

import 'aes256cipher_platform_interface.dart';

/// An implementation of [Aes256cipherPlatform] that uses method channels.
class MethodChannelAes256cipher extends Aes256cipherPlatform {
  /// The method channel used to interact with the native platform.

  final methodChannel = const MethodChannel('aes256cipher');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String> encrypt(
      String key, String data, int ivSpec, String transformation) async {
    Map<String, dynamic> params = {
      Aes256cipherConstant.paramKey: key,
      Aes256cipherConstant.paramData: data,
      Aes256cipherConstant.paramIvSpec: ivSpec,
      Aes256cipherConstant.paramTransformation: transformation,
    };
    return await methodChannel.invokeMethod<String>(
            Aes256cipherConstant.encrypt, params) ??
        "";
  }

  @override
  Future<String> decrypt(
      String key, String data, int ivSpec, String transformation) async {
    Map<String, dynamic> params = {
      Aes256cipherConstant.paramKey: key,
      Aes256cipherConstant.paramData: data,
      Aes256cipherConstant.paramIvSpec: ivSpec,
      Aes256cipherConstant.paramTransformation: transformation,
    };
    return await methodChannel.invokeMethod<String>(
            Aes256cipherConstant.decrypt, params) ??
        "";
  }
}
