
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/find_image/model/image_options.dart';
import 'package:online_study/features/listen_write/controller/listen_write_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class ListenWriteScreen extends StatelessWidget {
  ListenWriteScreen({super.key});
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    final ListenWriteController controller = Get.put(ListenWriteController());

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
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: isDark ? Colors.white : Color(0xff343A40),
            ),
          ),
          title: Text(
            "Listen & write",
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: isDark ? Color(0xffF1F3F5) : Color(0xff343A40),
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

  Widget _buildCompletionScreen(ListenWriteController controller) {
    final isDark = themeController.isDark.value;
    return Center(
      child: Container(
        margin: const EdgeInsets.all(24),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isDark
              ? AppDarkColors.backgroundColor
              : AppLightColors.backgroundColor,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
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
              style: GoogleFonts.inter(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: isDark
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

  Widget _buildQuizScreen(ListenWriteController controller) {
    return Column(
      children: [
        _buildProgressBar(controller),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Obx(() {
              if (controller.currentQuiz.questionType ==
                  QuestionType.multipleChoice) {
                return _buildMultipleChoiceQuestion(controller);
              } else {
                return _buildWordBankQuestion(controller);
              }
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar(ListenWriteController controller) {
    final isDark = themeController.isDark.value;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      color: isDark
          ? AppDarkColors.backgroundColor
          : AppLightColors.backgroundColor,
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.close),
              onPressed: controller.restartQuiz,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Obx(
                () => LinearProgressIndicator(
                  value: controller.progress,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Colors.orange,
                  ),
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Multiple Choice Question (4 options)
  Widget _buildMultipleChoiceQuestion(ListenWriteController controller) {
    final isDark = themeController.isDark.value;
    return Column(
      children: [
        Text(
          'Translate this sentence',
          style: GoogleFonts.inter(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            color: isDark
                ? AppDarkColors.primaryTextColor
                : AppLightColors.primaryTextColor,
          ),
        ),
        SizedBox(height: 18.h),
        _buildAudioCard(controller),
        SizedBox(height: 20.h),
        _buildMultipleChoiceOptions(controller),
        SizedBox(height: 18.h),
        Obx(
          () => controller.showFeedback.value
              ? _buildFeedback(controller)
              : const SizedBox.shrink(),
        ),
        SizedBox(height: 18.h),
        _buildContinueButton(controller),
        SizedBox(height: 16.h),
        Obx(
          () => Text(
            'Question ${controller.currentQuestionIndex.value + 1} of ${controller.quizData.length}',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14.sp),
          ),
        ),
      ],
    );
  }

  // Word Bank Question (8 words)
  Widget _buildWordBankQuestion(ListenWriteController controller) {
    final isDark = themeController.isDark.value;
    return Column(
      children: [
        Text(
          'Translate this sentence',
          style: GoogleFonts.inter(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            color: isDark
                ? AppDarkColors.primaryTextColor
                : AppLightColors.primaryTextColor,
          ),
        ),
        SizedBox(height: 18.h),
        _buildAudioCard(controller),
        SizedBox(height: 20.h),
        _buildSelectedWordsArea(controller),
        SizedBox(height: 20.h),
        _buildWordBankOptions(controller),
        SizedBox(height: 18.h),
        Obx(
          () => controller.showFeedback.value
              ? _buildFeedback(controller)
              : const SizedBox.shrink(),
        ),
        SizedBox(height: 20.h),
        _buildContinueButton(controller),
        SizedBox(height: 14.h),
        Obx(
          () => Text(
            'Question ${controller.currentQuestionIndex.value + 1} of ${controller.quizData.length}',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14.sp),
          ),
        ),
      ],
    );
  }

  Widget _buildAudioCard(ListenWriteController controller) {
    final isDark = themeController.isDark.value;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark
            ? AppDarkColors.backgroundColor
            : AppLightColors.backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade300, width: 2),
      ),
      child: Row(
        children: [
          Container(
            width: 50.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text('🦉', style: TextStyle(fontSize: 30.sp)),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              controller.currentQuiz.displayText,
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: isDark
                    ? AppDarkColors.primaryTextColor
                    : AppLightColors.primaryTextColor,
              ),
            ),
          ),
          Container(
            width: 40.w,
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.volume_up, color: Colors.blue),
              iconSize: 30.sp,
              onPressed: controller.playAudio,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMultipleChoiceOptions(ListenWriteController controller) {
    return Obx(() {
      final currentQuiz = controller.currentQuiz;
      return Column(
        children: List.generate(
          currentQuiz.options!.length,
          (index) => _buildMultipleChoiceOption(controller, index),
        ),
      );
    });
  }

  Widget _buildMultipleChoiceOption(
    ListenWriteController controller,
    int index,
  ) {
    final isDark = themeController.isDark.value;
    return Obx(() {
      final option = controller.currentQuiz.options![index];
      final isSelected = controller.selectedAnswer.value == index;
      final showCorrect = controller.showFeedback.value && option.isCorrect;
      final showWrong =
          controller.showFeedback.value && isSelected && !option.isCorrect;

      Color bgColor = isDark
          ? AppDarkColors.backgroundColor
          : AppLightColors.backgroundColor;
      Color borderColor = Colors.grey.shade300;

      if (showCorrect) {
        bgColor = Colors.green.shade100;
        borderColor = Colors.green.shade400;
      } else if (showWrong) {
        bgColor = Colors.red.shade100;
        borderColor = Colors.red.shade400;
      } else if (isSelected) {
        bgColor = Colors.blue.shade50;
        borderColor = Colors.blue.shade300;
      }

      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Material(
          color: bgColor,
          borderRadius: BorderRadius.circular(14.r),
          child: InkWell(
            onTap: () => controller.selectAnswer(index),
            borderRadius: BorderRadius.circular(14.r),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: borderColor, width: 2),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      option.text,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? AppDarkColors.primaryTextColor
                            : AppLightColors.primaryTextColor,
                      ),
                    ),
                  ),
                  if (showCorrect)
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 24,
                    ),
                  if (showWrong)
                    const Icon(Icons.cancel, color: Colors.red, size: 24),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildSelectedWordsArea(ListenWriteController controller) {
    return Obx(() {
      return Container(
        width: double.infinity,
        height: 150.h,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade300, width: 2),
        ),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: controller.selectedWords.map((word) {
            return _buildWordChip(word, true, controller);
          }).toList(),
        ),
      );
    });
  }

  Widget _buildWordBankOptions(ListenWriteController controller) {
    return Obx(() {
      final wordBank = controller.currentQuiz.wordBank!;
      return Wrap(
        spacing: 10,
        runSpacing: 10,
        alignment: WrapAlignment.center,
        children: wordBank.map((wordOption) {
          final isSelected = controller.selectedWords.contains(wordOption.word);
          return _buildWordChip(wordOption.word, isSelected, controller);
        }).toList(),
      );
    });
  }

  Widget _buildWordChip(
    String word,
    bool isSelected,
    ListenWriteController controller,
  ) {
    return GestureDetector(
      onTap: () => controller.toggleWord(word),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade100 : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? Colors.blue.shade400 : Colors.grey.shade400,
            width: 2,
          ),
        ),
        child: Text(
          word,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.blue.shade900 : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildFeedback(ListenWriteController controller) {
    final isCorrect = controller.isCorrectAnswer();

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isCorrect ? Colors.green.shade100 : Colors.red.shade100,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(
            isCorrect ? Icons.check_circle : Icons.cancel,
            color: isCorrect ? Colors.green.shade700 : Colors.red.shade700,
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              isCorrect
                  ? 'Correct! Great job!'
                  : 'Oops! Try selecting the correct answer.',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: isCorrect ? Colors.green.shade900 : Colors.red.shade900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton(ListenWriteController controller) {
  return Obx(() {
    bool isAnswerSelected;
    if (controller.currentQuiz.questionType == QuestionType.multipleChoice) {
      isAnswerSelected = controller.selectedAnswer.value != null;
    } else {
      isAnswerSelected = controller.selectedWords.isNotEmpty;
    }

    final isCorrect = controller.isCorrectAnswer();
    final showSkipButton = controller.showFeedback.value && !isCorrect;

    return Column(
      children: [
        // Continue Button (for correct answers or Check button)
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: !isAnswerSelected || showSkipButton
                ? null
                : controller.handleContinue,
            style: ElevatedButton.styleFrom(
              backgroundColor: controller.showFeedback.value && isCorrect
                  ? Colors.green
                  : Colors.green.shade400,
              disabledBackgroundColor: Colors.grey.shade300,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            child: Text(
              controller.showFeedback.value && isCorrect
                  ? 'Continue'
                  : 'Check',
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
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
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
