import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/ai_screens/lisining_dialouge/controller/lisining_dialouge_controller.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class LisitingAudio extends StatelessWidget {
  // Use Get.find to get the existing controller instance
  final LisiningDialougeController controller =
      Get.find<LisiningDialougeController>();

  LisitingAudio({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final langController = Get.find<LanguageController>();

    return Obx(() {
      final isDark = themeController.isDark.value;
      final currentQuestions = controller.listeningDialogue.value?.questions;

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
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          title: Text(
            langController.selectedLanguage["Listening Practice"] ??
                "Listening Practice",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
          child: Column(
            children: [
              // Waveform Section
              _buildAudioPlayer(isDark),
              SizedBox(height: 20.h),

              Text(
                langController
                        .selectedLanguage["Listen to the audio clip and answer the question"] ??
                    "Listen and Answer",
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 20.h),

              // Options Section
              if (currentQuestions != null && currentQuestions.isNotEmpty)
                _buildOptionsList(
                  currentQuestions[controller.currentQuestionIndex.value],
                  isDark,
                ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildAudioPlayer(bool isDark) {
    return Obx(() {
      final hasFile = controller.audioFile.value != null;
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: Colors.red[200],
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: !hasFile
            ? const Center(child: CircularProgressIndicator())
            : Row(
                children: [
                  IconButton(
                    icon: Icon(
                      controller.isPlaying.value
                          ? Icons.pause_circle
                          : Icons.play_circle,
                      size: 40.r,
                      color: const Color(0xFFCCFFFE),
                    ),
                    onPressed: () => controller.togglePlayPause(),
                  ),
                  Expanded(
                    child: AudioFileWaveforms(
                      size: Size(double.infinity, 80.h),
                      playerController: controller.playerController,
                      enableSeekGesture: true,
                      waveformType: WaveformType.long,
                      playerWaveStyle: PlayerWaveStyle(
                        fixedWaveColor: Colors.white54,
                        liveWaveColor: const Color(0xFFCCFFFE),
                      ),
                    ),
                  ),
                ],
              ),
      );
    });
  }

  Widget _buildOptionsList(dynamic question, bool isDark) {
    final answers = List.from(question.options ?? []);
    answers.shuffle();

    final userAnswer = controller.getUserAnswer(
      controller.currentQuestionIndex.value,
    );

    final correctAnswerIndexOriginal = question.correctOptionIndex;
    final correctAnswerText =
        question.options?[correctAnswerIndexOriginal].text;

    final correctAnswer = answers.indexWhere(
      (a) => a.text == correctAnswerText,
    );

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: answers.length,
      separatorBuilder: (_, _) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => controller.markAnswer(index),
          child: Container(
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
              color: _getAnswerColor(userAnswer, correctAnswer, index),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isDark ? Colors.white24 : Colors.black12,
              ),
            ),
            child: Text(
              answers[index].text ?? "",
              style: GoogleFonts.inter(
                fontSize: 15.sp,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getAnswerColor(int userAnswer, int correctAnswer, int index) {
    if (userAnswer == -1) return Colors.transparent;
    if (index == correctAnswer) return const Color(0xFFCCFFFE).withOpacity(0.5);
    if (index == userAnswer) return Colors.red[100]!;
    return Colors.transparent;
  }
}
