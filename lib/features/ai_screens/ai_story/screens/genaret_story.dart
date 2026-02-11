
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/ai_screens/ai_story/controller/ai_story_controller.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class GenaretStory extends StatelessWidget {
  GenaretStory({super.key});
  final AiStoryController controller = Get.put(AiStoryController());
  final langController = Get.find<LanguageController>();

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
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          title: Text(
            langController.selectedLanguage["Genaret Stories"] ?? "Genaret Stories",
            style: TextStyle(
              color: isDark
                  ? AppDarkColors.primaryTextColor
                  : AppLightColors.primaryTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(
                child: SpinKitCircle(color: AppDarkColors.primaryColor),
              );
            }

            if (controller.story.value == null) {
              return Center(
                child: Text(
                  langController.selectedLanguage["No story generated yet"] ?? "No story generated yet",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: isDark
                        ? AppDarkColors.primaryTextColor
                        : AppLightColors.primaryTextColor,
                  ),
                ),
              );
            }

            final story = controller.story.value!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🔹 Topic
                Center(
                  child: Text(
                    story.topic ?? '',
                    style: GoogleFonts.inter(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: AppDarkColors.primaryColor,
                    ),
                  ),
                ),

                SizedBox(height: 5.h),
                Divider(
                  color: isDark
                      ? AppDarkColors.primaryTextColor.withOpacity(0.3)
                      : AppLightColors.primaryTextColor.withOpacity(0.3),
                ),

                SizedBox(height: 5.h),

                /// 🔹 English Story
                Text(
                  langController.selectedLanguage["Story (English)"] ?? "Story (English)",
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppDarkColors.primaryTextColor
                        : AppLightColors.primaryTextColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  story.storyEnglish ?? '',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    height: 1.5.h,
                    color: isDark
                        ? AppDarkColors.primaryTextColor
                        : AppLightColors.primaryTextColor,
                  ),
                ),
                SizedBox(height: 20.h),

                /// 🔹 Target Language Story
                Text(
                  langController.selectedLanguage["Story (Target Language)"] ?? "Story (Target Language)",
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppDarkColors.primaryTextColor
                        : AppLightColors.primaryTextColor,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  story.storyTargetLanguage ?? '',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    height: 1.5.h,
                    color: isDark
                        ? AppDarkColors.primaryTextColor
                        : AppLightColors.primaryTextColor,
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            );
          }),
        ),
      );
    });
  }
}
