import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

class RolePlayController extends GetxController {
  final roleController = TextEditingController();
  final typeController = TextEditingController();

  RxBool showTextField = false.obs;
  RxBool showVoiceField = false.obs;
  RxBool isListening = false.obs;
  RxString voiceText = ''.obs;

  late stt.SpeechToText speech;
  RxDouble soundLevel = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    speech = stt.SpeechToText();
  }

  void showTextFieldValue() {
    showTextField.value = true;
    showVoiceField.value = false;
    isListening.value = false;
    voiceText.value = '';
  }

  void showVoiceFieldValue() {
    showVoiceField.value = true;
    showTextField.value = false;
    typeController.clear();
    isListening.value = false;
    voiceText.value = '';
  }

  Future<void> startListening() async {
    // Request microphone permission
    var status = await Permission.microphone.request();

    if (status.isGranted) {
      bool available = await speech.initialize(
        onStatus: (status) {
          print('Speech status: $status');
          if (status == 'done' || status == 'notListening') {
            isListening.value = false;
          }
        },
        onError: (errorNotification) {
          print('Speech error: $errorNotification');
          isListening.value = false;
          Get.snackbar(
            'Error',
            'Failed to recognize speech. Please try again.',
            snackPosition: SnackPosition.BOTTOM,
          );
        },
      );

      if (available) {
        isListening.value = true;
        voiceText.value = '';

        await speech.listen(
          onResult: (result) {
            voiceText.value = result.recognizedWords;
            soundLevel.value = result.hasConfidenceRating && result.confidence > 0
                ? result.confidence
                : 0.5;
          },
          listenFor: Duration(seconds: 30),
          pauseFor: Duration(seconds: 3),
          partialResults: true,
          cancelOnError: true,
          listenMode: stt.ListenMode.confirmation,
        );
      } else {
        Get.snackbar(
          'Error',
          'Speech recognition not available',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      Get.snackbar(
        'Permission Denied',
        'Microphone permission is required for voice input',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> stopListening() async {
    await speech.stop();
    isListening.value = false;
    soundLevel.value = 0.0;
  }

  @override
  void onClose() {
    roleController.dispose();
    typeController.dispose();
    speech.stop();
    super.onClose();
  }
}