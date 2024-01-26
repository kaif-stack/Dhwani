import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:developer' as devTools;
import 'package:flutter/services.dart';
import 'package:google_speech/google_speech.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:audioplayers/audioplayers.dart';
import '../../../../model/dhwani.dart';

class DhwaniMockScreen extends StatefulWidget {
  DhwaniMockScreen(
      {super.key,
      required this.dhwani,
      required this.alphabets,
      required this.mockType});

  final List<DhwaniClass> alphabets;
  final List<DhwaniElement> dhwani;
  final String mockType;

  @override
  State<DhwaniMockScreen> createState() => DhwaniMockScreenState();
}

class DhwaniMockScreenState extends State<DhwaniMockScreen> {
  final audioPlayer = FlutterSoundPlayer();
  int examplesLength = 28;
  bool isRecorded = false;
  bool isPlaying = false;
  int currentExample = 0;
  Color _containerColor = const Color(0xff00CAED);
  List<Example> selectedExamples = [];
  var file;
  File? audio;

  // Future<void> playAudioFromUrl(String url) async {
  //   await audioPlayer.play(UrlSource(url));
  // }

  void selectExamples() {
    if (widget.mockType == "categorised") {
      for (var alphabet in widget.alphabets) {
        for (var example in alphabet.examples) {
          selectedExamples.add(example);
        }
      }
    } else {
      for (var dhwanis in widget.dhwani) {
        for (var alphabet in dhwanis.dhwanis) {
          for (var example in alphabet.examples) {
            selectedExamples.add(example);
          }
        }
      }
    }
    if (widget.mockType == "categorised") {
      examplesLength = 15;
    }
    selectedExamples.shuffle(Random());
    if (selectedExamples.length > examplesLength) {
      selectedExamples = selectedExamples.sublist(0, examplesLength);
    }
  }

  var speechToText;

  @override
  void initState() {
    super.initState();
    selectExamples();
    final serviceAccount = ServiceAccount.fromString(r'''{
  "type": "service_account",
  "project_id": "alert-almanac-408515",
  "private_key_id": "d60a068c171d30bf62fd9060350854fcf7978d21",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCy7P/C3ULP8fcH\n5c90IDuHIkqMf3IF7xOthUzwz/y5TohHCcnC3zcnqAkIkWzyvcjorJ9Ph6ta1NaH\nfrXeEzaJHl9eMERaMlytY2Yh+u44cjGVE0JMiNB3CwAr+SJCP2EF8GC6q+pJS1m4\nbdNQaNYHfH0T0PQ+6r/sw6aS6kZfap404X6IY91CJdh5T08VEr7VmfzR8BUbCDEk\nwTXUFku9FbXKC2dmGs3MEk4/7V/su/Ob8LvA3BLxRdNf3psrCIy6KtqzvO2lUOUg\nDTOvvGnYqupxytWfy8CwOKg4t2ovmWqqLni5uBm6LkiY1i+/FDBm350TQtx86qF3\nlcUPsClrAgMBAAECggEALXdu+If8GdZNJTsfD82/ArRSiEg8Y8igUfgtGIZpnHcZ\nxx90HypUnCWlggFeU4KpgoKXCwEZKIAsMYsf0NpGAervZgJS5C6nAUJgaiMXFM3j\nzpNxxfwAKTfo58OrknUDhRxToCveYZidqHF0AJtbQ9S8/eObpT9G3PXMpsmUb1s9\nJhghI0x330i6lRv/uMVLo0a4ODubLmJe2ixrrzWNYXBjF+Ay576laNax/OdAFP8S\nt5tzuTlxya7WXrtuQT1F96AuFuT1qCTizG+IlSdDpUKF6+iA1GdFqdyBkB9XoIG/\ntikeg3K43sbfP1Ib0QWvAu0o4YlHmy2l6wQjmYXc1QKBgQD1V9MDYcQo/4cQweGu\nuuK8rZjChpTosMw4HR6FgPZvM37FGU0zp94IO2h+cEwDoHsU7L9LQkMKQhGj3Wda\nD6YwyBDXhnd4R+JBZhVoTPSDobr9uEuAsOzi+ZgHufTFiJZ+/tEZ8nnsffvlSSnD\na8+n2n47FR4g8R7WGWbS3fEDjwKBgQC6sqALRA1b0/44W79c12S0njn5Wv/+tL/8\nMCjzhaQw8i9sdn5RoJ9GKTcB8CdztLJxk+mjhQdIYnTc8dz23VWJHklc7Qu2U3hq\nyHdp6nkewMLhrE8qzKp9/S7X7s05Gn8d0JFjCwPZkoAAY3WuSvWFIlFSZQrKOCzm\nFQi+mGEeZQKBgG1gTulmD457hJpa5SMBnA2jksO+PeqSzyiBCtdXzAV9PpneEsXh\no6Gl4orjw2+mftiwRwPlMYAEPlsAXJARA/UhbCi5gM91tI+VVBvgmu2ID5YHMFna\nBnGV9koTg+UAZJ+POGdJ60McU00/1ceSa8wYI0hxvLHQ7P9j6aw+V7FPAoGBAIAS\nGuG/jB5rHWBR58LrawTP6dsZRrTWD0ETVHRBP/HnoQqZemvKcJgzm61zrcycrzBk\nlAh9MBLCn4IVVEvwZ0XJhe/+GGO5fMhbvjblBrNG7ijbB+/HOEl3DdRI13UNrRep\nxKIZo0l0SuR5Vff7KdNrSDfqYm13/azTzwzYAP9VAoGBALb+4ycrQO/P8JXxc11G\nOUmkJ1k1AK1gaNMBrxYY9pyRFtT8Mcxe2zoFUk6ezJYKwVvwxgQGRdrVsFPoOovR\n+dc9CdqFzWgUZury45OpLGYK/8R9ILfAMErUjwv7aFVM8Uvp5469eDuaEzHGdDDN\nu5cnC51y4q0n1EBJoRa/suuI\n-----END PRIVATE KEY-----\n",
  "client_email": "dhwani@alert-almanac-408515.iam.gserviceaccount.com",
  "client_id": "110602915677464936842",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/dhwani%40alert-almanac-408515.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''');
    speechToText = SpeechToText.viaServiceAccount(serviceAccount);

    initRecorder();
  }

  FlutterSoundRecorder? recorder;
  final recordingDataController = StreamController<Food>();

  @override
  void dispose() {
    FlutterSoundRecorder().closeRecorder();
    // audioPlayer.dispose();
    super.dispose();
  }

  var config;
  Future<void> initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw "Microphone permission not granted";
    }
    config = RecognitionConfig(
        encoding: AudioEncoding.LINEAR16,
        model: RecognitionModel.basic,
        enableAutomaticPunctuation: true,
        sampleRateHertz: 8000,
        audioChannelCount: 1,
        languageCode: 'en-US');
  }

  Future<String> createFile(String name) async {
    var tempDir = await getTemporaryDirectory();
    return '${tempDir.path}/$name.pcm';
  }

  Future record() async {
    recorder ??= await FlutterSoundRecorder().openRecorder();
    file = await createFile("audio");
    await recorder!
        .startRecorder(
            sampleRate: 8000, numChannels: 1, codec: Codec.pcm16, toFile: file)
        .onError((error, stackTrace) {
      devTools.log("Something went wrong when recording",
          error: error, stackTrace: stackTrace);
    });
    await Future.delayed(const Duration(seconds: 30));
    await stop();
    setState(() {
      isRecorded = true;
    });
  }

  late File audioFile;
  var textResponse = "h";
  Future stop() async {
    if (recorder == null) return;
    setState(() {
      _containerColor = const Color(0xff00caed);
    });

    await recorder?.stopRecorder();
    await recorder?.closeRecorder();
    recorder = null;

    try {
      audio = File(await createFile("audio"));
      if (audio != null) {
        await speechToText
            .recognize(config, await audio!.readAsBytes())
            .then((value) {
          setState(() {
            print(value);
            textResponse = value.toString();
          });
        });
      } else {
        print("Null Audio");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Center(
                child: Text(
                  "${currentExample + 1}/${selectedExamples.length}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 23,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                ),
                child: LinearProgressIndicator(
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  value: ((currentExample + 1) / selectedExamples.length),
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Color(0xff319F43)),
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 50.0),
            //   child: Image.network(
            //     selectedExamples[currentExample].image,
            //     width: screenWidth - 100,
            //     height: 300,
            //     fit: BoxFit.contain,
            //   ),
            // ),
            const SizedBox(height: 60),

            Text(
              textResponse,
              style: const TextStyle(color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedExamples[currentExample].name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 60,
                      fontFamily: "NotoSansDevanagari",
                      color: Color(0xff04434E),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // playAudioFromUrl(selectedExamples[currentExample].sound);
                    },
                    child: Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xff04434E),
                            offset: Offset(4, 4),
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: const Icon(CupertinoIcons.speaker_2_fill,
                          color: Color(0xff093955), size: 37),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () async {
                setState(() {
                  _containerColor = (_containerColor == const Color(0xff00caed))
                      ? const Color(0xff319F43)
                      : const Color(0xff00caed);
                });
                if (isRecorded) {
                  isPlaying = true;
                  setState(() {
                    _containerColor = const Color(0xff319F43);
                  });
                  await audioPlayer.openPlayer();
                  await audioPlayer.startPlayer(
                    fromURI: audio!.path,
                    codec: Codec.pcm16,
                    numChannels: 1,
                    sampleRate: 16000,
                  );
                  setState(() {
                    _containerColor = const Color(0xff00caed);
                  });
                } else {
                  await record();
                }
              },
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: _containerColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xff04434E),
                      offset: Offset(4, 4),
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Icon(
                    (isPlaying == true)
                        ? CupertinoIcons.waveform
                        : (isRecorded)
                            ? CupertinoIcons.play_fill
                            : CupertinoIcons.mic_fill,
                    color: Colors.white,
                    size: 75),
              ),
            ),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.only(left: 90),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textDirection: TextDirection.rtl,
                children: [
                  isRecorded
                      ? InkWell(
                          onTap: () {
                            currentExample += 1;
                            isRecorded = false;
                            isPlaying = false;
                            _containerColor = const Color(0xff00caed);
                            setState(() {});
                          },
                          child: Container(
                            width: 180,
                            height: 55,
                            decoration: const BoxDecoration(
                              color: Color(0xff319F43),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                bottomLeft: Radius.circular(50),
                              ),
                            ),
                            child: const Icon(
                              CupertinoIcons.checkmark_alt,
                              color: Colors.white,
                              size: 47,
                            ),
                          ),
                        )
                      : Container(),
                  isPlaying
                      ? InkWell(
                          onTap: () {
                            isRecorded = false;
                            isPlaying = false;
                            _containerColor = const Color(0xff00caed);
                            setState(() {});
                          },
                          child: Container(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                              color: const Color(0xffE33629),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Icon(CupertinoIcons.restart,
                                color: Colors.white, size: 28),
                          ),
                        )
                      : Container(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
