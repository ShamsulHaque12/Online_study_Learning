import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_study/features/ai_screens/ai_story/model/ai_story_model.dart';
import 'package:online_study/features/ai_screens/ai_story/screens/genaret_story.dart';
import 'package:online_study/services/api_endpoints.dart';
import 'package:online_study/services/network_caller.dart';

class AiStoryController extends GetxController {
  final storiesController = TextEditingController();
  final isLoading = false.obs;

  final Rxn<AiStoryModel> story = Rxn<AiStoryModel>();

  Future<void> aiGenaretStory() async {
    if (storiesController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a prompt to generate a story.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      final response = await NetworkCaller().postRequest(
        url: ApiEndpoints.genaretStory,
        body: {'topic': storiesController.text},
      );

      if (response.isSuccess) {
        final data = response.responseData as Map<String, dynamic>;

        /// Parse Model
        story.value = AiStoryModel.fromJson(data);
        Get.to(() => GenaretStory());

        log("Story parsed & stored");
      } else {
        Get.snackbar('Error', 'Failed to generate story');
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    storiesController.dispose();
    super.onClose();
  }
}
