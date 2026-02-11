import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:online_study/features/lesson_content/model/content_model.dart';
import 'package:online_study/features/lesson_content/screens/lesson_quiz_screen.dart';

class LessontContentController extends GetxController {
  final isLoading = false.obs;
  final currentIndex = 0.obs;
  ContentModel? content;

  late String lessonId;
  late String topicId;

  late PageController pageController;
  final FlutterTts tts = FlutterTts();

  @override
  void onInit() {
    pageController = PageController();
    if (Get.arguments != null && Get.arguments is ContentModel) {
    content = Get.arguments;

     lessonId = content!.data!.id!;
      topicId = content!.data!.contents!.isNotEmpty
          ? content!.data!.contents!.first.topicId ?? ""
          : "";

      // 🔹 Log for debugging
      log("Lesson ID: $lessonId, Topic ID: $topicId");
  }
    super.onInit();
  }

  ///.................Data.................///
 List<WordLearning> get lessons {
    if (content?.data?.contents?.isNotEmpty ?? false) {
      return content!.data!.contents!.first.wordLearning ?? [];
    }
    return [];
  }

  /// ---------------- PAGE ----------------
  void onPageChanged(int index) => currentIndex.value = index;

  void nextPage() {
    if (lessons.isEmpty) return;
    if (currentIndex.value < lessons.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (lessons.isEmpty) return;
    if (currentIndex.value > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  /// ---------------- TTS ----------------
  Future<void> speak(String? text) async {
    if (text == null || text.isEmpty) return;
    try {
      await tts.stop();
      await tts.speak(text);
    } catch (e) {
      log('TTS error: $e');
    }
  }

  /// ---------------- COMPLETE ----------------
  void completeLesson() {
    if (lessons.isEmpty) return;

    final quizzes = content?.data?.contents?.first.selectedLearning;
    if (quizzes != null && quizzes.isNotEmpty) {
      Get.to(() => LessonQuizScreen(quizzes: quizzes),arguments: {
        'topicId': topicId
      });
    } else {
      Get.snackbar('No Quizzes', 'No quizzes available for this lesson.');
    }
  }

  /// ---------------- DISPOSE ----------------
  @override
  void onClose() {
    pageController.dispose();
    tts.stop();
    super.onClose();
  }
}
