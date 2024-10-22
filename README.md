# 🛡️ AES256Cipher

AES256Cipher convert text to security module.

<br/>

## 📌 Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
current only possible Android/iOS (will be possible "iOS" 0.0.2 version later).

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
| ivSpec         | :x:                | bool   | true                   |


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

<br/>

## ⛑️ ivSpec parameter
- Return more security encrypted value.
- Default is `true`
- If you use `false` return always same value.

#### `ivSpec = true`
```dart
final String target = "Something Sentence";

final AES256Cipher cipher = AES256Cipher(key: "ABCDEFGH" * 4, ivSpec: true);
final String result = await cipher.encrypt(target);

Log.d("result:$result");
// result: d6RyFwWMFVcQN7juca9+ZH7L4ISYxbUblvLMe1XIU7yLIVEeJMzysW2FY22LRfX7
// length: 64
```

#### `ivSpec = false`
```dart
final String target = "Something Sentence";

final AES256Cipher cipher = AES256Cipher(key: "ABCDEFGH" * 4, ivSpec: false);
final String result = await cipher.encrypt(target);

Log.d("result:$result");
// result: ZAXCHBrpfp05oLP69/KNVO3Baxmrtcrxgx9ZZgysVY0=
// length: 44
```


<br/>
