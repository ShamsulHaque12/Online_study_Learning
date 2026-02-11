
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/components/custom_button.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_images.dart';
import 'package:online_study/features/lesson_content/controller/lesson_quiz_controller.dart';
import 'package:online_study/features/lesson_content/model/content_model.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class LessonQuizScreen extends StatelessWidget {
  final List<SelectedLearning> quizzes;
  const LessonQuizScreen({super.key, required this.quizzes});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LessonQuizController(quizzes));
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
        title: Obx(
          () => Text(
            "Question ${controller.currentIndex.value + 1} / ${quizzes.length}",
            style: GoogleFonts.inter(
              color: isDark
                  ? AppDarkColors.primaryTextColor
                  : AppLightColors.primaryTextColor,
            ),
          ),
        ),
      ),
      body: Obx(() {
        final q = controller.currentQuiz;

        final options = [
          {"key": "A", "option": q.options!.a!},
          {"key": "B", "option": q.options!.b!},
          {"key": "C", "option": q.options!.c!},
          {"key": "D", "option": q.options!.d!},
        ];

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  "Select the correct answer",
                  style: TextStyle(fontSize: 18.sp),
                ),
                const SizedBox(height: 16),

                /// Options Grid
                Expanded(
                  child: GridView.builder(
                    itemCount: options.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 1,
                        ),
                    itemBuilder: (_, index) {
                      final optionData = options[index];
                      final optionKey = optionData["key"] as String;
                      final option = optionData["option"] as A;

                      Color color = Colors.white;

                      /// Live feedback: mark correct/wrong
                      if (controller.isAnswered.value) {
                        if (optionKey == q.correctWord) {
                          color = Colors.green.shade200; // correct
                        } else if (optionKey ==
                            controller.selectedOptionKey.value) {
                          color = Colors.red.shade200; // wrong
                        } else {
                          color = Colors.grey.shade200; // neutral
                        }
                      }

                      return GestureDetector(
                        onTap: controller.isAnswered.value
                            ? null
                            : () => controller.select(optionKey),
                        child: Container(
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child:
                                    option.image != null &&
                                        option.image!.isNotEmpty
                                    ? Image.network(
                                        option.image!,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Image.asset(
                                            AppImages
                                                .defaultImage, // 🔁 fallback image
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      )
                                    : Image.asset(
                                        AppImages
                                            .defaultImage, // 🔁 image null hole
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  option.word ?? "",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 16.h),

                /// Stats
                if (controller.isAnswered.value)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Correct: ${controller.correctCount.value}",
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Wrong: ${controller.wrongCount.value}",
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                SizedBox(height: 16.h),

                /// Continue Button
                if (controller.isAnswered.value)
                  CustomButton(text: "Continue", onPressed: controller.next),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      }),
    );
    });
  }
}
