import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'aes256cipher_method_channel.dart';

abstract class Aes256cipherPlatform extends PlatformInterface {
  /// Constructs a Aes256cipherPlatform.
  Aes256cipherPlatform() : super(token: _token);

  static final Object _token = Object();

  static Aes256cipherPlatform _instance = MethodChannelAes256cipher();

  /// The default instance of [Aes256cipherPlatform] to use.
  ///
  /// Defaults to [MethodChannelAes256cipher].
  static Aes256cipherPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [Aes256cipherPlatform] when
  /// they register themselves.
  static set instance(Aes256cipherPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
