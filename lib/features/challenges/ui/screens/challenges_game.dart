
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_icons.dart';
import 'package:online_study/features/choose_ans/screens/quiz_screen.dart';
import 'package:online_study/features/choose_word/controller/matching_controller.dart';
import 'package:online_study/features/choose_word/model/questions_data.dart';
import 'package:online_study/features/choose_word/screens/matching_screen.dart';
import 'package:online_study/features/find_image/screens/image_screen.dart';
import 'package:online_study/features/listen_choose/screens/listen_choose_screen.dart';
import 'package:online_study/features/listen_write/screens/listen_write_screen.dart';
import 'package:online_study/features/write_word/screens/sentence_quiz_screen.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class ChallengesScreen extends StatelessWidget {
  ChallengesScreen({super.key});
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
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
            "Challenges",
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Color(0xffF1F3F5) : Color(0xff343A40),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: 1.0,
                  minHeight: 8.h,
                  borderRadius: BorderRadius.circular(4.r),
                  color: Color(0xffE46A28),
                  backgroundColor: isDarkMode
                      ? Color(0xffADB5BD)
                      : Color(0xffCED4DA),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Choose Game',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Color(0xffF1F3F5) : Color(0xff343A40),
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    gameContainer(
                      isDarkMode,
                      AppIcons.vocabularyIcon,
                      'Vocabulary',
                      onTap: () {
                        Get.to(() => QuizScreen());
                      },
                    ),
                    SizedBox(width: 16.w),
                    gameContainer(
                      isDarkMode,
                      AppIcons.choseWord,
                      'Matching Word',
                      onTap: () {
                        final questions = QuestionsData.getAllQuestions();
                        final controller = MatchingController(questions);
                        Get.put(controller);
                        Get.to(() => MatchingScreen());
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    gameContainer(
                      isDarkMode,
                      AppIcons.listenAndChose,
                      'Listen Choose',
                      onTap: () {
                        Get.to(() => ListenChooseScreen());
                      },
                    ),
                    SizedBox(width: 16.w),
                    gameContainer(
                      isDarkMode,
                      AppIcons.findImage,
                      'Find Image',
                      onTap: () {
                        Get.to(() => ImageScreen());
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    gameContainer(
                      isDarkMode,
                      AppIcons.writeWordIcon,
                      'Write Word',
                      onTap: () {
                        Get.to(() => SentenceQuizScreen());
                      },
                    ),
                    SizedBox(width: 16.w),
                    gameContainer(
                      isDarkMode,
                      AppIcons.listenAndWrite,
                      'Listen & Write',
                      onTap: () {
                        Get.to(() => ListenWriteScreen());
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget gameContainer(
    bool isDarkMode,
    String iconPath,
    String title, {
    VoidCallback? onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xffE46A28),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 40.r,
                backgroundColor: const Color(0xffFFCEB3),
                child: SvgPicture.asset(iconPath),
              ),
              SizedBox(height: 12.h),
              Container(
                height: 8.h,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode
                      ? const Color(0xff212529)
                      : const Color(0xffF8F9FA),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
