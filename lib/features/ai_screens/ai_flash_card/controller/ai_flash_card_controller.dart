
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:online_study/features/ai_screens/ai_flash_card/model/flash_card_model.dart';
import 'package:online_study/features/ai_screens/ai_flash_card/screens/flip_card_screen.dart';
import 'package:online_study/services/api_endpoints.dart';
import 'package:online_study/services/network_caller.dart';

class AiFlashCardController extends GetxController {
  final flashCardList = <FlashCardModel>[].obs;
  final FlutterTts flutterTts = FlutterTts();
  final logger = Logger();

  final flashCardGenerateLoading = false.obs;
  final currentFlashIndex = 0.obs;
  final isSpeaking = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeTts();
  }

  Future<void> _initializeTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);

    flutterTts.setStartHandler(() => isSpeaking.value = true);
    flutterTts.setCompletionHandler(() => isSpeaking.value = false);
    flutterTts.setErrorHandler((msg) {
      isSpeaking.value = false;
      logger.e('TTS Error: $msg');
    });
  }

  Future<void> speakWord() async {
    if (flashCardList.isEmpty) return;
    final flashcards = flashCardList.first.flashcards;
    if (flashcards.isEmpty || currentFlashIndex.value >= flashcards.length) return;

    final word = flashcards[currentFlashIndex.value].word ?? '';
    if (word.isNotEmpty) await flutterTts.speak(word);
  }

  Future<void> stopSpeaking() async {
    await flutterTts.stop();
    isSpeaking.value = false;
  }

  void nextFlashCard() {
    if (flashCardList.isEmpty) return;
    final flashcards = flashCardList.first.flashcards;
    if (flashcards.isEmpty) return;

    if (currentFlashIndex.value < flashcards.length - 1) {
      currentFlashIndex.value++;
    } else {
      _showCompletionPopup();
    }
  }

  void _showCompletionPopup() {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.celebration, size: 64, color: Color(0xffE46A28)),
              SizedBox(height: 16),
              Text('Congratulations!',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffE46A28))),
              SizedBox(height: 8),
              Text('You have completed all flashcards!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600])),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      currentFlashIndex.value = 0;
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffE46A28),
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text('Restart', style: TextStyle(color: Colors.white)),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Get.back();
                      Get.back();
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Color(0xffE46A28)),
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text('Exit', style: TextStyle(color: Color(0xffE46A28))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchFlashCards() async {
    final networkCaller = NetworkCaller();
    flashCardGenerateLoading.value = true;

    try {
      final response = await networkCaller.postRequest(
        url: ApiEndpoints.generateFlashCards,
        body: {},
      );

      if (response.isSuccess && response.responseData != null) {
        final flashCardModel = FlashCardModel.fromJson(response.responseData!);
        flashCardList.add(flashCardModel);
        Get.to(() => FlipCardScreen());
        logger.i('Flashcards fetched: ${response.responseData}');
      } else {
        logger.e('Failed to fetch flashcards: ${response.responseData}');
      }
    } catch (e) {
      logger.e('Error fetching flashcards: $e');
    } finally {
      flashCardGenerateLoading.value = false;
    }
  }

  @override
  void onClose() {
    flutterTts.stop();
    super.onClose();
  }
}
