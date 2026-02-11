
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_icons.dart';
import 'package:online_study/features/Ai/ui/controller/ai_screen_controller.dart';
import 'package:online_study/features/ai_screens/ai_dictionary/screens/ai_dictionary_screen.dart';
import 'package:online_study/features/home/controller/lesson_controller.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/global/widgets/custom_appbar.dart';
import 'package:online_study/route/app_routes.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class AiScreen extends StatelessWidget {
  AiScreen({super.key});
  final AiScreenController controller = Get.put(AiScreenController());
  final LessonController lessonController = Get.put(LessonController());
  final langController = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(() {
      final isDark = themeController.isDark.value;
      return Scaffold(
        appBar: CustomAppBar(
          fireCount: lessonController.user.value?.streak ?? 0,
          notoCount: lessonController.user.value?.totalPoint ?? 0,
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    aiFeatureCard(
                      isDark,
                      langController.selectedLanguage['Flashcards'] ??
                          'Flashcards',
                      langController
                              .selectedLanguage['Review vocabulary with smart AI-powered flashcards'] ??
                          'Review vocabulary with smart AI-powered flashcards',
                      AppIcons.flashCardIcon,

                      () {
                        Get.toNamed(AppRoutes.aiFlashCard);
                      },
                    ),
                    SizedBox(width: 12.w),
                    aiFeatureCard(
                      isDark,
                      langController.selectedLanguage['AI Role-Play'] ??
                          'AI Role-Play',
                      langController
                              .selectedLanguage['Practice conversations with AI in real scenarios'] ??
                          'Practice conversations with AI in real scenarios',
                      AppIcons.rolePlayIcon,

                      () {
                        Get.toNamed(AppRoutes.aiRolePlayTalk);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    aiFeatureCard(
                      isDark,
                      langController.selectedLanguage['Listening Drill'] ??
                          'Listening Drill',
                      langController
                              .selectedLanguage['Improve comprehension with native audio'] ??
                          'Improve comprehension with native audio',
                      AppIcons.listeningDrillIcon,

                      () {
                        Get.toNamed(AppRoutes.lisiningDialougeScreen);
                      },
                    ),
                    SizedBox(width: 12.w),
                    aiFeatureCard(
                      isDark,
                      langController.selectedLanguage['Writing Practice'] ??
                          'Writing Practice',
                      langController
                              .selectedLanguage['Write sentences and get AI feedback'] ??
                          'Write sentences and get AI feedback',
                      AppIcons.writingPractise,

                      () {
                        Get.toNamed(AppRoutes.writingPracticeScreen);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    aiFeatureCard(
                      isDark,
                      langController.selectedLanguage['Camera'] ?? 'Camera',
                      langController
                              .selectedLanguage['Point learn objects in real life'] ??
                          'Point learn objects in real life',
                      AppIcons.cameraIcon,

                      () {
                        Get.toNamed(AppRoutes.aiCamera);
                      },
                    ),
                    SizedBox(width: 12.w),
                    aiFeatureCard(
                      isDark,
                      langController.selectedLanguage['AI Dictionary'] ??
                          'AI Dictionary',
                      langController
                              .selectedLanguage['Translate & learn with examples'] ??
                          'Translate & learn with examples',
                      AppIcons.dictionaryIcon,

                      () {
                        // Get.toNamed(AppRoutes.aiDictionary);
                        Get.to(() => AiDictionaryScreen());
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    aiFeatureCard(
                      isDark,
                      langController.selectedLanguage['Short Stories'] ??
                          'Short Stories',
                      langController
                              .selectedLanguage['Read & practice with mini narratives'] ??
                          'Read & practice with mini narratives',
                      AppIcons.storiesIcon,

                      () {
                        Get.toNamed(AppRoutes.aiStoryScreen);
                      },
                    ),
                    SizedBox(width: 12.w),
                    aiFeatureCard(
                      isDark,
                      langController.selectedLanguage['Dialogue Builder'] ??
                          'Dialogue Builder',
                      langController
                              .selectedLanguage['Arrange conversation bubbles in correct order'] ??
                          'Arrange conversation bubbles in correct order',
                      AppIcons.dialogueBuilderIcon,

                      () {
                        Get.toNamed(AppRoutes.aiDialougeScreen);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    aiFeatureCard(
                      isDark,
                      langController.selectedLanguage['Roleplay Simulation'] ??
                          'Roleplay Simulation',
                      langController
                              .selectedLanguage['Arrange conversation bubbles in correct order'] ??
                          'Arrange conversation bubbles in correct order',
                      AppIcons.rolePlaySimulationIcon,
                      () {
                        Get.toNamed(AppRoutes.aiRolePlayScreen);
                      },
                    ),
                    SizedBox(width: 12.w),
                    Expanded(child: Container()),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget aiFeatureCard(
    bool isDarkMode,
    String title,
    String description,
    String iconPath,
    VoidCallback? onTap,
  ) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          height: 180.h,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: isDarkMode ? Color(0xff212529) : Color(0xffF8F9FA),
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
            border: Border.all(
              color: isDarkMode
                  ? AppDarkColors.backgroundColor
                  : AppLightColors.backgroundColor,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: AppDarkColors.primaryColor,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: SvgPicture.asset(iconPath),
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Color(0xffF1F3F5) : Color(0xff343A40),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,

                  color: isDarkMode ? Color(0xffDEE2E6) : Color(0xff868E96),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
