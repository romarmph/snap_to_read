import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translator/translator.dart';
import 'package:flutter_tts/flutter_tts.dart';

class VisionProvider extends ChangeNotifier {
  String _recognizedSource = "";
  String _recognizedOutput = "";
  String _imageFile = "";

  String get getRecognizedSource => _recognizedSource;
  String get getRecognizedOutput => _recognizedOutput;
  String get getImageFile => _imageFile;

  set setSource(String inut) {
    _recognizedSource = inut;
    notifyListeners();
  }

  set setOutput(String inut) {
    _recognizedOutput = inut;
    notifyListeners();
  }

  final List<TextRecognitionScript> scripts = [
    TextRecognitionScript.latin,
    TextRecognitionScript.chinese,
    TextRecognitionScript.japanese,
    TextRecognitionScript.korean,
  ];

  TextRecognizer _textRecognizer = TextRecognizer();
  void fromCamera(int scriptIndex) async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    _textRecognizer = TextRecognizer(
      script: scripts[scriptIndex],
    );

    final visionText = await _textRecognizer.processImage(
      InputImage.fromFilePath(image!.path),
    );

    _recognizedSource = visionText.text;
    _imageFile = image.path;
    notifyListeners();
    translate();
    _textRecognizer.close();
  }

  void fromGallery(int scriptIndex) async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    _textRecognizer = TextRecognizer(
      script: scripts[scriptIndex],
    );

    RecognizedText visionText;

    visionText = await _textRecognizer.processImage(
      InputImage.fromFilePath(image!.path),
    );

    _recognizedSource = visionText.text;
    _imageFile = image.path;
    notifyListeners();
    translate();
    _textRecognizer.close();
  }

  final List<String> _languages = [
    "English",
    "Chinese",
    "Japanese",
    "Korean",
  ];

  int _sourceIndex = 0;
  int _outputIndex = 0;

  int get getSourceIndex => _sourceIndex;
  int get getOutputIndex => _outputIndex;

  String get getSourceanguage => _languages[_sourceIndex];
  String get getOutputlanguage => _languages[_outputIndex];

  set setSourceLanguage(int input) {
    _sourceIndex = input;
    notifyListeners();
  }

  set setOutputLanguage(int input) {
    _outputIndex = input;
    notifyListeners();
  }

  void translate() async {
    final List<String> locales = [
      "en",
      "zh-cn",
      "ja",
      "ko",
    ];
    final translater = GoogleTranslator();

    final translated = await translater.translate(
      _recognizedSource,
      to: locales[_outputIndex],
    );

    _recognizedOutput = translated.text;
    notifyListeners();
  }

  final speaker = FlutterTts();

  Future ttsConfig() async {
    await speaker.setSpeechRate(0.5);
    await speaker.setVolume(1.0);
    await speaker.setPitch(0.5);
  }

  Future speakSource() async {
    final List<String> locales = [
      "en",
      "zh-cn",
      "ja-JP",
      "ko-KR",
    ];
    speaker.setLanguage(locales[_sourceIndex]);
    if (_recognizedSource.isNotEmpty) {
      await speaker.speak(_recognizedSource);
    }
  }

  Future speakOutput() async {
    final List<String> locales = [
      "en",
      "zh-cn",
      "ja-JP",
      "ko-KR",
    ];
    speaker.setLanguage(locales[_outputIndex]);
    if (_recognizedOutput.isNotEmpty) {
      await speaker.speak(_recognizedOutput);
    }
  }

  Future pause() async {
    await speaker.pause();
  }

  Future stop() async {
    await speaker.stop();
  }
}
