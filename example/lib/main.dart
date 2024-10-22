import 'package:aes256cipher/aes256cipher.dart';
import 'package:flutter/material.dart';
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
  late final AES256Cipher aes256Cipher;

  String platformVersion = "Unknown";

  String encryptResult = "";
  String decryptResult = "";

  // This code will be solve your doubt.
  final String test1 = "dQuPSKM9NB3WxoHlBNkhlU924xnuJkW9UHBr91oFatepq41N3iIdhEqUTV5UHl77";
  final String test2 = "u3mQx2xrhxLh2wDmKjV2Owk8aPxJoJAe5dUlRgb3V7NdqlpUlSxk6yX6r5Q0h3L+";

  final TextStyle titleStyle = const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
  );

  @override
  void initState() {
    super.initState();
    aes256Cipher = AES256Cipher(key: "A1234567B1234567C1234567D1234567", ivSpec: false);

    loadVersion();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AES256Cipher Example Demo'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Platform:" ,style: titleStyle),
              Text(platformVersion),
              const SizedBox(height: 12.0,),
              const Text("aesKey:",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600
                ),
              ),
              const Text("A1234567B1234567C1234567D1234567"),
              const SizedBox(height: 12.0,),

              Row(
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        // key: a * 32
                        encryptResult = await aes256Cipher.encrypt("Something Sentence");
                        Log.i("encryptResult:$encryptResult");
                        Log.i("length:${encryptResult.length}");
                        // length: Always:65 = iv + encrypted
                        // length: Always:45 = encrypted

                        // length: 64(iOS) = iv + encrypted
                        // length: 44(iOS) = encrypted
                        setState(() {});
                      },
                      child: const Text("encrpyt")),
                  const Text("  < < <  \"Something Sentence\"")
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(encryptResult),
              ),

              Visibility(
                visible: encryptResult.isNotEmpty,
                child: const Padding(
                  padding: EdgeInsets.only(left: 18.0),
                  child: Text("⌄\n⌄\n⌄"),
                ),
              ),

              ElevatedButton(
                onPressed: () async {
                  // String result = await aes256Cipher.decrypt("something");
                  decryptResult = await aes256Cipher.decrypt(encryptResult);

                  final testResult1 = await aes256Cipher.decrypt(test1);
                  final testResult2 = await aes256Cipher.decrypt(test2);
                  Log.x("decryptResult:$decryptResult");

                  Log.x("decryptResult1:$testResult1");
                  Log.x("decryptResult2:$testResult2");
                  setState(() {});
                },
                child: const Text("decrypt"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(decryptResult),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loadVersion() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      platformVersion = await aes256Cipher.getPlatformVersion();
      setState(() {});
    },);
  }
}
