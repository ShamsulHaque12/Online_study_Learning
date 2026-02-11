
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/components/custom_button_widget.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/choose_ans/controller/quiz_controller.dart';
import 'package:online_study/features/choose_ans/model/quiz_option.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class QuizScreen extends StatelessWidget {
  final QuizController controller = Get.put(QuizController());

  QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(() {
      final isDark = themeController.isDark.value;
    return Scaffold(
      backgroundColor: isDark
          ? AppDarkColors.backgroundColor
          : AppLightColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDark
            ? AppDarkColors.backgroundColor
            : AppLightColors.backgroundColor,
        leading: IconButton(
          onPressed: Get.back,
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          'Choose Answer',
          style: TextStyle(
            color: isDark
                ? AppDarkColors.primaryTextColor
                : AppLightColors.primaryTextColor,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.showResult.value) {
          return _buildResultScreen();
        }
        return _buildQuizScreen();
      }),
    );
    });
  }

  Widget _buildQuizScreen() {
    return Column(
      children: [
        _buildProgressBar(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildQuestionCard(),
                const SizedBox(height: 24),
                _buildOptionsGrid(),
                const SizedBox(height: 24),
                Obx(() {
                  if (controller.isAnswered.value) {
                    return _buildContinueButton();
                  }
                  return const SizedBox.shrink();
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar() {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.isDark.value;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Text(
                  'Question ${controller.currentQuestion.value + 1} of ${controller.quizData.length}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? AppDarkColors.primaryTextColor
                        : AppLightColors.primaryTextColor,
                  ),
                ),
              ),
              Obx(
                () => Text(
                  'Score: ${controller.score.value}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Obx(
            () => LinearProgressIndicator(
              value:
                  (controller.currentQuestion.value + 1) /
                  controller.quizData.length,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(
                AppDarkColors.primaryColor,
              ),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard() {
    final question = controller.getCurrentQuestion();
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.isDark.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select the correct answer',
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: isDark
                ? AppDarkColors.primaryTextColor
                : AppLightColors.primaryTextColor,
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppDarkColors.primaryColor, width: 2.w),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  question.question,
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppDarkColors.primaryTextColor
                        : AppLightColors.primaryTextColor,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              IconButton(
                onPressed: () => controller.playAudio(question.audioText),
                icon: Icon(Icons.volume_up, color: Colors.white),
                style: IconButton.styleFrom(
                  backgroundColor: AppDarkColors.primaryColor,
                  padding: const EdgeInsets.all(12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOptionsGrid() {
    final question = controller.getCurrentQuestion();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemCount: question.options.length,
      itemBuilder: (context, index) {
        final option = question.options[index];
        return _buildOptionCard(option);
      },
    );
  }

  Widget _buildOptionCard(QuizOption option) {
    return Obx(() {
      final isSelected = controller.selectedOption.value == option.id;
      final isAnswered = controller.isAnswered.value;

      Color backgroundColor = Colors.white;
      Color borderColor = Colors.grey.shade300;
      Widget? icon;

      if (isAnswered) {
        if (option.isCorrect) {
          backgroundColor = Colors.green.shade50;
          borderColor = Colors.green;
          icon = Icon(Icons.check_circle, color: Colors.green, size: 28);
        } else if (isSelected && !option.isCorrect) {
          backgroundColor = Colors.red.shade50;
          borderColor = Colors.red;
          icon = const Icon(Icons.cancel, color: Colors.red, size: 28);
        }
      }

      return GestureDetector(
        onTap: () => controller.handleOptionClick(option),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: borderColor, width: 2),
            boxShadow: [
              if (!isAnswered)
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
            ],
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text(option.emoji, style: TextStyle(fontSize: 48)),
                  Image.network(option.emoji, height: 70.h, width: 70.w),
                  SizedBox(height: 12),
                  Text(
                    option.text,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              if (icon != null) Positioned(top: 0, right: 0, child: icon),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildContinueButton() {
    return CustomButtonWidget(
      text: "Continue",
      onTap: () => controller.handleContinue(),
      backgroundColor: AppDarkColors.primaryColor,
    );
  }

  // Widget _buildContinueButton() {
  //   return SizedBox(
  //     height: 45.h,
  //     width: double.infinity,
  //     child: ElevatedButton(
  //       onPressed: () => controller.handleContinue(),
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: Colors.green,
  //         padding: const EdgeInsets.symmetric(vertical: 20),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(16),
  //         ),
  //         elevation: 4,
  //       ),
  //       child: Text(
  //         'Continue',
  //         style: TextStyle(
  //           fontSize: 16.sp,
  //           fontWeight: FontWeight.bold,
  //           color: Colors.white,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildResultScreen() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue.shade50, Colors.white],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 15,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('🎉', style: TextStyle(fontSize: 80)),
                SizedBox(height: 24),
                Text(
                  'Quiz Complete!',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 16.h),
                Obx(
                  () => Text(
                    '${controller.score.value}/${controller.quizData.length}',
                    style: const TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Obx(() {
                  final score = controller.score.value;
                  final total = controller.quizData.length;
                  String message;

                  if (score == total) {
                    message = 'Perfect Score!';
                  } else if (score >= total * 0.7) {
                    message = 'Great Job!';
                  } else {
                    message = 'Keep Practicing!';
                  }

                  return Text(
                    message,
                    style: TextStyle(fontSize: 20.sp, color: Colors.grey),
                  );
                }),
                SizedBox(height: 32.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.resetQuiz(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      elevation: 4,
                    ),
                    child: Text(
                      'Try Again',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
