import 'package:aes256cipher/src/aes256cipher_const.dart';

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
  ///
  /// 2024-10-21
  /// Changed type [int] to [bool].
  ///
  /// The [ivSpec] size is default 16.
  /// So [ivSpec] property was changed decide to availability.
  ///
  /// -
  ///
  /// [ivSpec] is default 'true'.
  /// It is more protect encrypted sentence.
  /// return 65 length String.
  ///
  /// [ivSpec] is 'false'
  /// It is not use 'iv'.
  /// return 45 length String.
  ///
  /// -
  ///
  /// Use param [Aes256cipherConstant.paramIvSpec].
  final bool ivSpec;

  /// transformation into Cipher
  ///
  /// [transformation] default : AES/CBC/PKCS5Padding
  final String transformation = "AES/CBC/PKCS5Padding";

  /// required key char length '32'
  ///
  /// @deprecated [ivSpec], [transformation]
  /// Fix values can have been felt to easy it
  AES256Cipher({
    required this.key,
    this.ivSpec = true,
    // this.transformation = "AES/CBC/PKCS5Padding"
  }) {
    if (key.length != 32) {
      throw Exception(" AES256Cipher constructor [key] parameter required '32' text length, because The cipher key required 32-bit.");
    }
  }

  /// native Platform Version
  Future<String> getPlatformVersion() async {
    return await Aes256cipherPlatform.instance.getPlatformVersion() ??
        "Unknown";
  }

  /// encrypt function
  ///
  /// if you want URLEncoder.encode result then you can use
  /// Uri.encodeComponent function from dart:core
  Future<String> encrypt(String data) async {
    return Aes256cipherPlatform.instance
        .encrypt(key, data, ivSpec, transformation);
  }

  /// decrypt function
  ///
  /// if you want URLDecoder.decode result then you can use
  /// Uri.decodeComponent function from dart:core
  Future<String> decrypt(String data) async {
    return Aes256cipherPlatform.instance
        .decrypt(key, data, ivSpec, transformation);
  }
}
