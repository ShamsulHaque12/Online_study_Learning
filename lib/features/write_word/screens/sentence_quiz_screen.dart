
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/components/custom_button_widget.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/write_word/controller/sentence_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class SentenceQuizScreen extends StatelessWidget {
  final SentenceController controller = Get.put(SentenceController());

  SentenceQuizScreen({super.key});

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
          'Sentence Quiz',
          style: TextStyle(
            color: isDark
                ? AppDarkColors.primaryTextColor
                : AppLightColors.primaryTextColor,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildProgressBar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                children: [
                  _buildDisplaySentence(),
                  SizedBox(height: 20.h),

                  //  DROP / ARRANGE CONTAINER
                  _buildContainardWords(),

                  SizedBox(height: 20.h),

                  // AVAILABLE WORDS
                  _buildAvailableWords(),
                  Spacer(),
                  _buildCheckButton(),
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    });
  }

  // ---------------- PROGRESS ----------------
  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Obx(
        () => LinearProgressIndicator(
          value:
              (controller.currentQuestion.value + 1) /
              controller.questions.length,
          minHeight: 6,
          backgroundColor: Colors.grey.shade300,
          valueColor: AlwaysStoppedAnimation<Color>(AppDarkColors.primaryColor),
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }

  // ---------------- QUESTION ----------------
  Widget _buildDisplaySentence() {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.isDark.value;

    return Obx(() {
      final q = controller.getCurrentQuestion();
      return Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isDark ? Colors.white30 : AppDarkColors.borderColor,
            width: 1.w,
          ),
        ),
        child: Text(
          q.displaySentence,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: isDark
                ? AppDarkColors.primaryTextColor
                : AppLightColors.primaryTextColor,
          ),
        ),
      );
    });
  }

  // ---------------- DROP / ARRANGED WORDS ----------------
  Widget _buildContainardWords() {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.isDark.value;

    return Obx(() {
      final words = controller.arrangedWords;

      return Container(
        width: double.infinity,
        constraints: BoxConstraints(minHeight: 90.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey.shade900 : Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isDark ? Colors.white24 : AppDarkColors.borderColor,
            width: 1.2,
          ),
        ),
        child: words.isEmpty
            ? Center(
                child: Text(
                  'Tap words to build sentence',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              )
            : Wrap(
                spacing: 8,
                runSpacing: 8,
                children: words.map((word) {
                  return GestureDetector(
                    onTap: () => controller.removeWordFromArranged(word),
                    child: _wordChip(
                      word,
                      isDark ? Colors.blueGrey.shade700 : Colors.blue.shade100,
                    ),
                  );
                }).toList(),
              ),
      );
    });
  }

  // ---------------- AVAILABLE WORDS ----------------
  Widget _buildAvailableWords() {
    return Obx(() {
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: controller.availableWords.map((word) {
          return GestureDetector(
            onTap: () => controller.addWordToArranged(word),
            child: _wordChip(word, Colors.grey.shade300),
          );
        }).toList(),
      );
    });
  }

  // ---------------- CHIP ----------------
  Widget _wordChip(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Text(text, style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
    );
  }

  // ---------------- CHECK ----------------
  Widget _buildCheckButton() {
    return Obx(() {
      return CustomButtonWidget(
        text: "Check",
        onTap: controller.arrangedWords.isNotEmpty
            ? controller.checkAnswer
            : null,
        backgroundColor: AppDarkColors.primaryColor,
      );
    });
  }
}
