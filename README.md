# aes256cipher

AES256Cipher secure module.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
current only possible Android (will be possible "and/or iOS" later).

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## 🍔add
```dart
flutter pub add aes256cipher
```

## 🚀usage

#### create instance

| parameter      | required           | type   |  default               |
|----------------|--------------------|--------|------------------------|
| key            | :heavy_check_mark: | String |                        |
| ivSpec         | :x:                | Int    |  16                    |
| transformation | :x:                | String |  AES/CBC/PKCS5Padding  |

```dart
final AES256Cipher aes256Cipher = AES256Cipher(key: [String - length: 32]);

ex) aes256Cipher = AES256Cipher(key: "a" * 32);
```

#### encrypt
```dart
final String value = "something";

final String encryptResult = aes256Cipher.encrypt(value);    // hD5BBkxQWdEMu5PNncxtGw==
```

#### decrypt
```dart
final String decryptResult = aes256Cipher.decrypt(encryptResult);    // [B@552ab2b
```
