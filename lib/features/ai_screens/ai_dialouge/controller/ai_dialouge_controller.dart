import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/ai_screens/ai_dialouge/model/ai_dialogue_model.dart';
import 'package:online_study/features/ai_screens/ai_dialouge/screens/dialuge_builder_screen.dart';
import 'package:online_study/features/ai_screens/ai_dialouge/widgets/dialouge_completed_popup.dart';
import 'package:online_study/services/api_endpoints.dart';
import 'package:online_study/services/network_caller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class AiDialougeController extends GetxController {
  final dialougeController = TextEditingController();

  final isLoading = false.obs;

  /// 🔥 Dialogue Data
  final Rxn<AiDialogueModel> dialogue = Rxn<AiDialogueModel>();

  /// Step Logic
  final currentStep = 1.obs;
  final currentStepAnswer = RxnInt();

  int get totalSteps => dialogue.value?.questions.length ?? 0;

  double get progress => totalSteps == 0 ? 0 : currentStep.value / totalSteps;

  DialogueQuestion get currentQuestion =>
      dialogue.value!.questions[currentStep.value - 1];

  bool get canSend => currentStepAnswer.value != null;

  Color get sendButtonColor => canSend ? Colors.green : Colors.grey;

  /// Generate Dialogue
  /// ================================
  Future<void> aiGenaretDialouge() async {
    if (dialougeController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter a prompt to generate a dialogue.');
      return;
    }

    try {
      isLoading.value = true;

      final response = await NetworkCaller().postRequest(
        url: ApiEndpoints.dialougeBuilder,
        body: {'scenario': dialougeController.text},
        customTimeout: Duration(minutes: 3),
      );

      if (response.isSuccess) {
        dialogue.value = AiDialogueModel.fromJson(response.responseData!);

        currentStep.value = 1;
        currentStepAnswer.value = null;
        Get.to(() => DialugeBuilderScreen());

        log("Dialogue generated successfully");
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Select Answer
  /// ================================
  void selectAnswer(int index) {
    currentStepAnswer.value = index;
  }

  /// Send Answer & Go Next
  /// ================================
  void sendAnswer() {
    if (!canSend) return;

    if (currentStep.value < totalSteps) {
      currentStep.value++;
      currentStepAnswer.value = null;
    } else {
      Get.dialog(
        DialougeCompletedPopup(
          onRestart: () {
            currentStep.value = 1;
            currentStepAnswer.value = null;
          },
        ),
        barrierDismissible: false,
      );
    }
  }

  /// Bottom Sheet for Options
  /// ================================
  void openBottomSheet() {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.isDark.value;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark
              ? AppDarkColors.backgroundColor
              : AppLightColors.backgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(currentQuestion.options.length, (index) {
            final option = currentQuestion.options[index];
            return ListTile(
              title: Text(
                option.tagalog,
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
              ),
              subtitle: Text(
                option.english,
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
              ),
              onTap: () {
                selectAnswer(index);
                Get.back();
              },
            );
          }),
        ),
      ),
      isScrollControlled: true,
    );
  }
}
