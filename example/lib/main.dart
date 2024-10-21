import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:aes256cipher/aes256cipher.dart';
import 'package:flutter_logcat/flutter_logcat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  late final AES256Cipher aes256Cipher;

  String encryptResult = "hello world! this encrypt result";
  String decryptResult = "";

  @override
  void initState() {
    super.initState();
    aes256Cipher = AES256Cipher(key: "donguran123456781234567812345678");
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await aes256Cipher.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    Log.i("platformVersion:$platformVersion");
    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Running on: $_platformVersion\n'),
              Text(encryptResult),
              ElevatedButton(
                  onPressed: () async {
                    // key: a * 32
                    encryptResult = await aes256Cipher.encrypt("something");
                    // encryptResult = Uri.encodeComponent(await aes256Cipher.encrypt("something"));
                    print("encryptResult:$encryptResult");
                    setState(() {});
                  },
                  child: Text("encrpyt")),
              const SizedBox(
                height: 24.0,
              ),
              Text(decryptResult),
              ElevatedButton(
                onPressed: () async {
                  // String result = await aes256Cipher.decrypt("something");
                  decryptResult = await aes256Cipher.decrypt(encryptResult);
                  // decryptResult = Uri.decodeComponent(result);
                  print("decryptResult:$decryptResult");
                  setState(() {});
                },
                child: Text("decrypt"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
