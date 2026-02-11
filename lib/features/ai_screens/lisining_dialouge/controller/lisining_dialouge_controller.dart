import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:async';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/ai_screens/lisining_dialouge/screens/lisiting_audio.dart';
import 'package:online_study/services/api_endpoints.dart';
import 'package:path_provider/path_provider.dart';
import '../model/listening_dialouge_model.dart';

class LisiningDialougeController extends GetxController {
  final textController = TextEditingController();
  final isLoading = false.obs;

  late final PlayerController playerController;
  final listeningDialogue = Rx<ListeningDialogueModel?>(null);
  final currentQuestionIndex = 0.obs;
  final userAnswered = <int, int>{}.obs;
  final isPlaying = false.obs;
  final audioFile = Rxn<File>();

  bool _isPreparing = false;

  @override
  void onInit() {
    super.onInit();
    playerController = PlayerController();

    playerController.onPlayerStateChanged.listen((state) {
      isPlaying.value = state == PlayerState.playing;
    });

    playerController.onCompletion.listen((_) async {
      isPlaying.value = false;
      await playerController.stopPlayer();
    });
  }

  @override
  Future<void> onClose() async {
    try {
      await playerController.stopPlayer();
      playerController.dispose();
    } catch (e) {
      log("Dispose error: $e");
    }
    await _deleteCurrentTempFile();
    textController.dispose();
    super.onClose();
  }

  Future<void> _deleteCurrentTempFile() async {
    try {
      if (audioFile.value != null && await audioFile.value!.exists()) {
        await audioFile.value!.delete();
      }
    } catch (e) {
      log("File delete error: $e");
    }
  }

  Future<void> aiDialougeListining() async {
    if (textController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter some text');
      return;
    }

    try {
      isLoading.value = true;
      final response = await http
          .post(
            Uri.parse(ApiEndpoints.dialougeLisenting),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'topic': textController.text}),
          )
          .timeout(const Duration(minutes: 2));

      if (response.statusCode == 200) {
        listeningDialogue.value = ListeningDialogueModel.fromJson(
          Map<String, dynamic>.from(jsonDecode(response.body)),
        );

        currentQuestionIndex.value = 0;
        userAnswered.clear();

        Get.to(() => LisitingAudio());
        Future.delayed(
          const Duration(milliseconds: 500),
          () => playAudioForCurrentQuestion(),
        );
      }
    } catch (e) {
      log('Fetch error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> playAudioForCurrentQuestion() async {
    if (_isPreparing) return; // Prevent overlap
    final convId = listeningDialogue.value?.conversationId;
    final qIndex = currentQuestionIndex.value;
    if (convId == null) return;

    try {
      _isPreparing = true;

      // Download audio on background
      final url = '${ApiEndpoints.textToSpeech}$convId/$qIndex';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
        await _deleteCurrentTempFile();

        // File writing is fast enough, but wrap in try/catch
        final dir = await getTemporaryDirectory();
        final filePath =
            '${dir.path}/audio_temp_${DateTime.now().millisecondsSinceEpoch}.wav';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        audioFile.value = file;

        // Use compute or isolate if waveform extraction is too heavy
        await _safePlayerLogic(filePath);
      }
    } catch (e) {
      log('Audio request error: $e');
    } finally {
      _isPreparing = false;
    }
  }

  Future<void> _safePlayerLogic(String path) async {
    try {
      // Reset player
      await playerController.stopPlayer();

      try {
        await playerController.preparePlayer(
          path: path,
          shouldExtractWaveform: false,
          noOfSamples: 50,
        );
      } catch (waveformError) {
        log("Waveform extraction skipped: $waveformError");
      }

      await playerController.startPlayer();
      isPlaying.value = true;
    } catch (e) {
      log('Critical Player Failure: $e');
    }
  }

  Future<void> togglePlayPause() async {
    if (playerController.playerState == PlayerState.playing) {
      await playerController.pausePlayer();
    } else {
      await playerController.startPlayer();
    }
  }

  Future<void> nextQuestion() async {
    if (_isPreparing) return; 
    if (currentQuestionIndex.value <
        (listeningDialogue.value?.questions?.length ?? 0) - 1) {
      currentQuestionIndex.value++;
      await playAudioForCurrentQuestion();
    }
  }

  void markAnswer(int selectedOptionIndex) {
    if (userAnswered.containsKey(currentQuestionIndex.value)) return;
    userAnswered[currentQuestionIndex.value] = selectedOptionIndex;
    _startNextQuestionDelay();
  }

  Future<void> _startNextQuestionDelay() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!Get.isRegistered<LisiningDialougeController>()) return;

    if (isLastQuestion) {
      // Get.snackbar('Completed', 'Great job!');
      _showCompletedPopup();
    } else {
      // Call nextQuestion safely
      unawaited(nextQuestion());
    }
  }

  int getUserAnswer(int questionIndex) => userAnswered[questionIndex] ?? -1;
  bool get isLastQuestion =>
      currentQuestionIndex.value ==
      (listeningDialogue.value?.questions?.length ?? 1) - 1;

  
  ///............dialouge
  void _showCompletedPopup() {
  Get.dialog(
    WillPopScope(
      onWillPop: () async => false, 
      child: AlertDialog(
        backgroundColor: AppLightColors.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          '🎉 Completed!',
          textAlign: TextAlign.center,
        ),

        content: const Text(
          'Great job! You have completed all questions.',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.back(); 
            },
            child: const Text('OK'),
          ),
        ],
      ),
    ),
    barrierDismissible: false,
  );
}

}

