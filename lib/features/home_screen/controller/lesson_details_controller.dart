import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../../core/app_images.dart';
import '../model/word_model.dart';

class LessonDetailsController extends GetxController {
  var words = <WordModel>[].obs;
  var currentIndex = 0.obs;
  var isLoading = true.obs;
  var isListening = false.obs;

  final AudioPlayer audioPlayer = AudioPlayer();
  final FlutterTts tts = FlutterTts();

  late stt.SpeechToText speech;
  var spokenText = "".obs;

  @override
  void onInit() {
    super.onInit();
    speech = stt.SpeechToText();
    loadWords();
  }

  /// Load sample data
  void loadWords() {
    words.assignAll([
      WordModel(
        id: 1,
        word: "Mag-anak",
        translation: "Family",
        image: AppImages.family,
        ttsText: "Family",
        audio: "audio/family.mp3",
      ),
      WordModel(
        id: 2,
        word: "Tatay",
        translation: "Father",
        image: AppImages.family,
        ttsText: "Father",
        audio: "audio/father.mp3",
      ),
      WordModel(
        id: 3,
        word: "Nanay",
        translation: "Mother",
        image: AppImages.family,
        ttsText: "Mother",
        audio: "audio/mother.mp3",
      ),
    ]);

    isLoading(false);
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  double get progress =>
      words.isEmpty ? 0 : (currentIndex.value + 1) / words.length;

  WordModel get currentWord => words[currentIndex.value];

  /// Play mp3
  Future<void> playAudio(String path) async {
    await audioPlayer.stop();
    await audioPlayer.play(AssetSource(path));
  }

  /// Speak translation
  Future<void> speakText(String text) async {
    await tts.setLanguage("en-US");
    await tts.setPitch(1.0);
    await tts.setSpeechRate(0.9);
    await tts.speak(text);
  }

  /// Start speech-to-text with auto-stop
  Future<void> startListening() async {
    bool available = await speech.initialize();

    if (available) {
      isListening.value = true;

      speech.listen(
        onResult: (result) {
          spokenText.value = result.recognizedWords;

          /// Update translation text live
          words[currentIndex.value] = words[currentIndex.value].copyWith(
            translation: spokenText.value,
          );

          /// Auto-stop when speech is final
          if (result.finalResult) {
            stopListening();
          }
        },
        listenFor: Duration(seconds: 10),
        pauseFor: Duration(seconds: 3),
      );
    }
  }

  void stopListening() {
    speech.stop();
    isListening.value = false;
  }

  /// Show completion dialog
  void showCompletionPopup() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Success Icon
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 60,
                ),
              ),
              SizedBox(height: 20),

              // Title
              Text(
                '🎉 Congratulations!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),

              // Message
              Text(
                'You have completed this lesson!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 24),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back(); // Close dialog
                        Get.back(); // Go back to previous screen
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text('Go Back'),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back(); // Close dialog
                        currentIndex.value = 0; // Reset to first page
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text('Restart'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    tts.stop();
    speech.stop();
    super.onClose();
  }
}