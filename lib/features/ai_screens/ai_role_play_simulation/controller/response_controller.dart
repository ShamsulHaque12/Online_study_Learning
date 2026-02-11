import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:online_study/features/ai_screens/ai_role_play_simulation/model/ai_role_play_response_model.dart';
import 'package:online_study/features/ai_screens/ai_role_play_simulation/model/role_currection_model.dart';
import 'package:online_study/services/api_endpoints.dart';
import 'package:online_study/services/network_caller.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ResponseController extends GetxController {
  var isVoiceMode = true.obs;
  final isLoading = false.obs;

  final TextEditingController textController = TextEditingController();

  final rolePlayResponse = Rx<RolePlayResponseModel?>(null);
  final roleCorrection = Rx<RoleCorrectionModel?>(null);

  late stt.SpeechToText _speech;
  var isListening = false.obs;

  @override
  void onInit() {
    super.onInit();
    _speech = stt.SpeechToText();
    generateRolePlayResponse();
  }

  /// 🎤 Start Speech To Text
  Future<void> startVoiceRecording() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        if (status == "done") {
          isListening.value = false;
        }
      },
      onError: (error) {
        isListening.value = false;
        log(error.errorMsg);
      },
    );

    if (available) {
      isListening.value = true;
      _speech.listen(
        onResult: (result) {
          textController.text = result.recognizedWords;
        },
      );
    }
  }

  /// ⛔ Stop Recording
  void stopVoiceRecording() {
    _speech.stop();
    isListening.value = false;
  }

  /// 🧠 Role Play Question
  Future<void> generateRolePlayResponse() async {
    try {
      isLoading.value = true;
      final response = await NetworkCaller().postRequest(
        url: ApiEndpoints.roleSimulationEvaluation,
        body: {},
      );

      if (response.isSuccess) {
        rolePlayResponse.value =
            RolePlayResponseModel.fromJson(response.responseData!);
      }
    } finally {
      isLoading.value = false;
    }
  }

  /// ✅ Submit & Get Correction
  Future<void> currectResponse() async {
    if (textController.text.trim().isEmpty) return;

    try {
      isLoading.value = true;

      final response = await NetworkCaller().postRequest(
        url: ApiEndpoints.roleCorrection,
        body: {
          "scenario": rolePlayResponse.value?.scenario,
          "question_in_language": rolePlayResponse.value?.questionInLanguage,
          "question_english": rolePlayResponse.value?.questionEnglish,
          "user_response": textController.text.trim(),
          "language": rolePlayResponse.value?.language,
        },
      );

      if (response.isSuccess) {
        roleCorrection.value =
            RoleCorrectionModel.fromJson(response.responseData!);
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    textController.dispose();
    _speech.stop();
    super.onClose();
  }
}
