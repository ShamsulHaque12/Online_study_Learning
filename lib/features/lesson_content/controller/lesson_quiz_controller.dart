import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_icons.dart';
import 'package:online_study/constraints/app_images.dart';
import 'package:online_study/features/lesson_content/model/content_model.dart';
import 'package:online_study/features/lesson_content/widgets/total_point_card.dart';
import 'package:online_study/route/app_routes.dart';
import 'package:online_study/services/api_endpoints.dart';
import 'package:online_study/services/network_caller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class LessonQuizController extends GetxController {
  final List<SelectedLearning> quizzes;
  LessonQuizController(this.quizzes);

  final String topicId = Get.arguments["topicId"];

  final currentIndex = 0.obs;
  final selectedOptionKey = "".obs;
  final isAnswered = false.obs;
  final correctCount = 0.obs;

  final RxInt totalPoint = 0.obs;
  final RxInt wrongCount = 0.obs;
  final RxInt totalTime = 0.obs;
  final isLoading = false.obs;

  /// Timer
  late DateTime quizStartTime;
  Timer? timer;
  final elapsed = Duration.zero.obs;

  SelectedLearning get currentQuiz => quizzes[currentIndex.value];

  @override
  void onInit() {
    super.onInit();
    _startQuizTimer();
    log("Quiz Screen: Lesson ID =  Topic ID = $topicId");
  }

  void _startQuizTimer() {
    quizStartTime = DateTime.now();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      elapsed.value = DateTime.now().difference(quizStartTime);
    });
  }

  void _stopQuizTimer() => timer?.cancel();

  void select(String optionKey) {
    if (isAnswered.value) return;
    selectedOptionKey.value = optionKey;
    isAnswered.value = true;

    // ✅ Correct answer
    if (optionKey == currentQuiz.correctWord) {
      correctCount.value++;
    }

    //  Update totalPoints live
    totalPoint.value = correctCount.value * 5;

    //  Update wrong count automatically
    wrongCount.value = quizzes.length - correctCount.value;
  }

  void next() {
    if (currentIndex.value < quizzes.length - 1) {
      currentIndex.value++;
      selectedOptionKey.value = "";
      isAnswered.value = false;
    } else {
      _stopQuizTimer();
      totalTime.value = elapsed.value.inSeconds;
      _showCompletionPopup();
      submitProgress();
    }
  }

  Future<void> submitProgress() async {
    try {
      isLoading.value = true;

      final body = {
        "moduleType": "LESSON",
        "referenceId": topicId,
        "status": "COMPLETED",
        "meta": {
          "totalPoints": totalPoint.value,
          "timeTakenSec": totalTime.value,
          "correctAnswers": correctCount.value,
          "wrongAnswers": wrongCount.value,
        },
      };

      log("Submitting Progress: $body");

      final response = await NetworkCaller().postRequest(
        url: ApiEndpoints.updateProgress,
        body: body,
      );

      if (response.isSuccess) {
        log("Progress submitted successfully!");
      } else {
        log("Progress submission failed: ${response.errorMessage}");
      }
    } catch (e) {
      log("Error submitting progress: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void _showCompletionPopup() {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.isDark.value;
    Get.dialog(
      Dialog(
        backgroundColor: isDark
            ? AppDarkColors.backgroundColor
            : AppLightColors.backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(AppImages.pakhi, height: 100.h, width: 100.w),
              SizedBox(height: 4.h),
              Text(
                "Congratulations!",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark
                      ? AppDarkColors.primaryTextColor
                      : AppLightColors.primaryTextColor,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "You have completed this Quiz.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: isDark
                      ? AppDarkColors.primaryTextColor
                      : AppLightColors.primaryTextColor,
                ),
              ),
              SizedBox(height: 8.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  TotalPointCard(
                    title: "Total Point",
                    pointText: "${totalPoint.value}",
                    iconPath: AppIcons.notoIcon,
                    backgroundColor: AppDarkColors.primaryColor,
                  ),
                  TotalPointCard(
                    title: "Cor. Ans",
                    pointText: "${correctCount.value}",
                    iconPath: AppIcons.goal,
                    backgroundColor: AppDarkColors.primaryColor,
                  ),
                  TotalPointCard(
                    title: "Wrong Ans",
                    pointText: "${wrongCount.value}",
                    iconPath: AppIcons.time,
                    backgroundColor: AppDarkColors.primaryColor,
                  ),
                  TotalPointCard(
                    title: "Time",
                    pointText: "${totalTime.value}",
                    iconPath: AppIcons.time,
                    backgroundColor: AppDarkColors.primaryColor,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                "Total Questions: ${quizzes.length}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                  color: isDark
                      ? AppDarkColors.primaryTextColor
                      : AppLightColors.primaryTextColor,
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppDarkColors.primaryColor,
                      ),
                      onPressed: () {
                        Get.offAllNamed(AppRoutes.bottomNavScreen);
                      },
                      child: Text(
                        "Go Back",
                        style: TextStyle(color: Colors.white),
                      ),
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
    _stopQuizTimer();
    super.onClose();
  }
}
