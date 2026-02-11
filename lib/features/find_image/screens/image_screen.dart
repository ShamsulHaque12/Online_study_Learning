
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/find_image/controller/image_controller.dart';
import 'package:online_study/features/find_image/screens/multipel_choice_screen.dart';
import 'package:online_study/features/find_image/screens/true_false_screen.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class ImageScreen extends StatelessWidget {
  ImageScreen({super.key});

  final ImageController controller = Get.put(ImageController());

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
          'Find Image',
          style: TextStyle(
            color: isDark
                ? AppDarkColors.primaryTextColor
                : AppLightColors.primaryTextColor,
          ),
        ),
      ),
      body: Column(
        children: [
          _progressBar(),
          Expanded(
            child: Obx(() {
              return controller.isMultipleChoice
                  ? MultipleChoiceScreen()
                  : TrueFalseScreen();
            }),
          ),
        ],
      ),
    );
    });
  }

  Widget _progressBar() {
    return Obx(() {
      final progress =
          (controller.currentQuestion.value + 1) / controller.quizData.length;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: LinearProgressIndicator(
          value: progress,
          minHeight: 6,
          backgroundColor: Colors.grey.shade300,
          valueColor: AlwaysStoppedAnimation<Color>(AppDarkColors.primaryColor),
          borderRadius: BorderRadius.circular(12.r),
        ),
      );
    });
  }
}
