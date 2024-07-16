
import 'aes256cipher_platform_interface.dart';

class Aes256cipher {
  Future<String?> getPlatformVersion() {
    return Aes256cipherPlatform.instance.getPlatformVersion();
  }
}
