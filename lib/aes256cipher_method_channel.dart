import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'aes256cipher_platform_interface.dart';

/// An implementation of [Aes256cipherPlatform] that uses method channels.
class MethodChannelAes256cipher extends Aes256cipherPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('aes256cipher');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
