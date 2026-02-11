import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_study/route/app_routes.dart';
import 'package:online_study/services/api_endpoints.dart';
import 'package:online_study/services/network_caller.dart';

class AiWrittingController extends GetxController {
  final promtController = TextEditingController();
  final promt = ''.obs;
  final isLoading = false.obs;
  final promtLoading = false.obs;

  @override
  void onInit() async {
    await fethPrompt();
    super.onInit();
  }

  Future<void> fethPrompt() async {
  try {
    promtLoading.value = true;

    final response = await NetworkCaller().postRequest(
      url: ApiEndpoints.aiGeneratePrompt,
      body: {},
    );

    if (response.isSuccess) {
      log('Prompt Data: ${response.responseData}');

      promt.value = response.responseData?['prompt'] ?? '';

    } else {
      log('Prompt Error: ${response.errorMessage}');
    }
  } catch (e) {
    log(e.toString());
  } finally {
    promtLoading.value = false;
  }
}


  Future<void> promptData() async {
  if (promtController.text.isEmpty || promt.value.isEmpty) {
    Get.snackbar('Error', 'Please enter a prompt');
    return;
  }

  try {
    isLoading.value = true;

    final response = await NetworkCaller().postRequest(
      url: ApiEndpoints.aiEvaluateWriting,
      body: {
        'prompt': promt.value,
        'user_response': promtController.text,
      },
    );

    if (response.isSuccess) {
      log('Evaluate Writing Data: ${response.responseData}');

      // ✅ PASS FULL RESPONSE
      Get.toNamed(
        AppRoutes.responseWrittingScreen,
        arguments: response.responseData,
      );

    } else {
      log('Evaluate Writing Error: ${response.errorMessage}');
      
    }
  } catch (e) {
    log(e.toString());
  } finally {
    isLoading.value = false;
  }
}

}
