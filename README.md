# AES256Cipher

AES256Cipher convert text to security module.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
current only possible Android (will be possible "and/or iOS" later).

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

<br/>

## 🍔 Add
```dart
flutter pub add aes256cipher
```

```dart
import 'package:aes256cipher/aes256cipher.dart';
```

<br/>

## 🚀 Usage

#### Create instance 🌱
-  You must input 32-bit char into `key` parameter.
-  Don't use different own your `key`🔑.

| parameter      | required           | type   |  default               |
|----------------|--------------------|--------|------------------------|
| key            | :heavy_check_mark: | String |                        |


```dart
final AES256Cipher aes256Cipher = AES256Cipher(key: [String - length: 32]);
```

```dart
// ex.
final AES256Cipher aes256cipher = AES256Cipher(key: "A1234567B1234567C1234567D1234567");
```
<br/>

### Encrypted 🔐
```dart
final String value = "Something Sentence";

final String encryptResult = aes256Cipher.encrypt(value);
// encryptResult: OUPswS1JeArwaeKSvGtaAeb3C+Sm8UookvDIwwGk9c2XNhtqClmRADo1r4MXUGiY
```

### Decrypted 🔓
```dart
final String decryptResult = aes256Cipher.decrypt(encryptResult);   // encryptedResult: OUPswS1JeArwaeKSvGtaAeb3C+Sm8UookvDIwwGk9c2XNhtqClmRADo1r4MXUGiY
// decryptResult: Something Sentence
```

<br/>

|  iOS|  Android|
|-----|---------|
|<img src="https://github.com/user-attachments/assets/3ffcc795-4a5d-4768-abd4-7e3e4a9e9ba8" alt="iOS Exam GIF" width="250">|<img src="https://github.com/user-attachments/assets/70abe2ad-82ae-42bf-bb3f-aec60cd5c633" alt="Android Exam GIF" width="250">|
