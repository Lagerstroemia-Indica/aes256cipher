import 'aes256cipher_platform_interface.dart';

/// only UTF-8
class AES256Cipher {
  /// AES key
  ///
  /// [key] is unique own key.
  /// required Char [32] length.
  final String key;

  /// default 16 byteArray
  /// this property is into IvParameterSpec and AlgorithmParameterSpec
  final int ivSpec;

  /// transformation into Cipher
  ///
  /// [transformation] default : AES/CBC/PKCS5Padding
  final String transformation;

  AES256Cipher(
      {required this.key,
      this.ivSpec = 16,
      this.transformation = "AES/CBC/PKCS5Padding"}) {
    if (key.length != 32) {
      throw Exception("""AES256Cipher [key] property required 32 length,
       because input 32 bit into AES256Cipher 256 bit key""");
    }
  }

  /// native Platform Version
  Future<String?> getPlatformVersion() {
    return Aes256cipherPlatform.instance.getPlatformVersion();
  }

  /// encrypt function
  ///
  /// if you want URLEncoder.encode result then you can use
  /// Uri.encodeComponent function from dart:core
  Future<String> encrypt(String data) {
    return Aes256cipherPlatform.instance
        .encrypt(key, data, ivSpec, transformation);
  }

  /// decrypt function
  ///
  /// if you want URLDecoder.decode result then you can use
  /// Uri.decodeComponent function from dart:core
  Future<String> decrypt(String data) {
    return Aes256cipherPlatform.instance
        .decrypt(key, data, ivSpec, transformation);
  }
}
