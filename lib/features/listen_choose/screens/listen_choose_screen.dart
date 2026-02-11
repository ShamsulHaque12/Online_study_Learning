
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/listen_choose/controller/listen_quiz_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class ListenChooseScreen extends StatelessWidget {
  ListenChooseScreen({super.key});
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    final ListenQuizController controller = Get.put(ListenQuizController());

    return Obx(() {
      final isDarkMode = themeController.isDark.value;
      return Scaffold(
        backgroundColor: isDarkMode
            ? AppDarkColors.backgroundColor
            : AppLightColors.backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: isDarkMode
              ? AppDarkColors.backgroundColor
              : AppLightColors.backgroundColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: isDarkMode ? Colors.white : Color(0xff343A40),
            ),
          ),
          title: Text(
            "Listen & Choose",
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Color(0xffF1F3F5) : Color(0xff343A40),
            ),
          ),
        ),
        body: Obx(() {
          if (controller.quizCompleted.value) {
            return _buildCompletionScreen(controller);
          }
          return _buildQuizScreen(controller);
        }),
      );
    });
  }

  Widget _buildCompletionScreen(ListenQuizController controller) {
    final isDarkMode = themeController.isDark.value;
    return Center(
      child: Container(
        margin: EdgeInsets.all(24),
        padding: EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: isDarkMode
              ? AppDarkColors.backgroundColor
              : AppLightColors.backgroundColor,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20.r,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 100.w,
              height: 100.h,
              decoration: BoxDecoration(
                color: Colors.yellow.shade400,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text('🎉', style: TextStyle(fontSize: 50.sp)),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Quiz Complete!',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: isDarkMode
                    ? AppDarkColors.primaryTextColor
                    : AppLightColors.primaryTextColor,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Your Score: ${controller.score.value}/${controller.quizData.length}',
              style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade700),
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.restartQuiz,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  'Restart Quiz',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizScreen(ListenQuizController controller) {
    final isDarkMode = themeController.isDark.value;
    return Column(
      children: [
        _buildProgressBar(controller),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                //  SizedBox(height: 20),
                Text(
                  'What do you hear',
                  style: GoogleFonts.inter(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode
                        ? AppDarkColors.primaryTextColor
                        : AppLightColors.primaryTextColor,
                  ),
                ),
                SizedBox(height: 20.h),
                _buildAudioButton(controller),
                SizedBox(height: 30.h),
                _buildOptions(controller),
                SizedBox(height: 20.h),
                Obx(
                  () => controller.showFeedback.value
                      ? _buildFeedback(controller)
                      : const SizedBox.shrink(),
                ),
                SizedBox(height: 10.h),
                _buildContinueButton(controller),
                SizedBox(height: 12.h),
                Obx(
                  () => Text(
                    'Question ${controller.currentQuestionIndex.value + 1} of ${controller.quizData.length}',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar(ListenQuizController controller) {
    final isDarkMode = themeController.isDark.value;
    return Container(
      color: isDarkMode
          ? AppDarkColors.backgroundColor
          : AppLightColors.backgroundColor,
      padding: const EdgeInsets.all(16),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: controller.restartQuiz,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Obx(
                () => LinearProgressIndicator(
                  value: controller.progress,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                  minHeight: 12,
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAudioButton(ListenQuizController controller) {
    return GestureDetector(
      onTap: controller.playAudio,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade500, Colors.orange.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Icon(Icons.volume_up, size: 60.sp, color: Colors.white),
      ),
    );
  }

  Widget _buildOptions(ListenQuizController controller) {
    return Obx(() {
      final currentQuiz = controller.currentQuiz;
      return Column(
        children: List.generate(
          currentQuiz.options.length,
          (index) => _buildOptionButton(controller, index),
        ),
      );
    });
  }

  Widget _buildOptionButton(ListenQuizController controller, int index) {
    final isDarkMode = themeController.isDark.value;
    return Obx(() {
      final option = controller.currentQuiz.options[index];
      final isSelected = controller.selectedAnswer.value == index;
      final showCorrect = controller.showFeedback.value && option.isCorrect;
      final showWrong =
          controller.showFeedback.value && isSelected && !option.isCorrect;

      Color bgColor = isDarkMode
          ? AppDarkColors.backgroundColor
          : AppLightColors.backgroundColor;
      Color borderColor = Colors.grey.shade300;
      Color textColor = isDarkMode
          ? AppDarkColors.primaryTextColor
          : AppLightColors.primaryTextColor;

      if (showCorrect) {
        bgColor = Colors.green.shade100;
        borderColor = Colors.green.shade500;
        textColor = Colors.green.shade900;
      } else if (showWrong) {
        bgColor = Colors.red.shade100;
        borderColor = Colors.red.shade500;
        textColor = Colors.red.shade900;
      } else if (isSelected) {
        bgColor = Colors.blue.shade100;
        borderColor = Colors.blue.shade500;
        textColor = Colors.blue.shade900;
      }

      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Material(
          color: bgColor,
          borderRadius: BorderRadius.circular(16.r),
          child: InkWell(
            onTap: () => controller.selectAnswer(index),
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(color: borderColor, width: 2),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      option.text,
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                  ),
                  if (showCorrect)
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  if (showWrong)
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildFeedback(ListenQuizController controller) {
    final isCorrect =
        controller.selectedAnswer.value != null &&
        controller
            .currentQuiz
            .options[controller.selectedAnswer.value!]
            .isCorrect;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCorrect ? Colors.green.shade100 : Colors.red.shade100,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Text(
        isCorrect
            ? '✓ Correct! Great job!'
            : '✗ Oops! Try selecting the correct answer.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: isCorrect ? Colors.green.shade900 : Colors.red.shade900,
        ),
      ),
    );
  }

  Widget _buildContinueButton(ListenQuizController controller) {
  return Obx(() {
    final isAnswerSelected = controller.selectedAnswer.value != null;
    final isCorrect =
        isAnswerSelected &&
        controller
            .currentQuiz
            .options[controller.selectedAnswer.value!]
            .isCorrect;
    final showSkipButton = controller.showFeedback.value && !isCorrect;

    return Column(
      children: [
        // Continue/Check Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: !isAnswerSelected || showSkipButton
                ? null
                : controller.handleContinue,
            style: ElevatedButton.styleFrom(
              backgroundColor: controller.showFeedback.value && isCorrect
                  ? Colors.green
                  : Colors.orange,
              disabledBackgroundColor: Colors.grey.shade300,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            child: Text(
              controller.showFeedback.value && isCorrect ? 'Continue' : 'Check',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: !isAnswerSelected || showSkipButton
                    ? Colors.grey.shade500
                    : Colors.white,
              ),
            ),
          ),
        ),
        
        // Skip Button (only show when answer is wrong)
        if (showSkipButton) ...[
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controller.skipQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade600,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                elevation: 2,
              ),
              child: Text(
                'Skip',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  });
}
}
