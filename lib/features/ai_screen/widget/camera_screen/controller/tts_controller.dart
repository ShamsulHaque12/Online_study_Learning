import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class TtsController extends GetxController {
  RxString language = "ENG".obs;
  RxString word = "Silya".obs;
  RxString pronunciation = "/Sil-ya/".obs;
  RxString meaning = "pic name".obs;
  RxString example = "Example Sentence".obs;

  final FlutterTts flutterTts = FlutterTts();

  final Map<String, Map<String, String>> textData = {
    "ENG": {
      "word": "Silya",
      "pronunciation": "/Sil-ya/",
      "meaning": "pic name",
      "example": "Example Sentence"
    },
    "TAG": {
      "word": "Silya",
      "pronunciation": "/Sil-ya/",
      "meaning": "pangalan ng larawan",
      "example": "Halimbawa ng pangungusap"
    }
  };

  void changeLanguage(String lang) {
    language.value = lang;
    word.value = textData[lang]!["word"]!;
    pronunciation.value = textData[lang]!["pronunciation"]!;
    meaning.value = textData[lang]!["meaning"]!;
    example.value = textData[lang]!["example"]!;
  }

  void speak(String text) async {
    await flutterTts.setLanguage(language.value == "ENG" ? "en-US" : "tl-PH");
    await flutterTts.speak(text);
  }
}