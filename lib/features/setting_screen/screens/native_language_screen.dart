
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_images.dart';
import 'package:online_study/features/setting_screen/controller/native_language_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class NativeLanguageScreen extends StatelessWidget {
  NativeLanguageScreen({super.key});
  final NativeLanguageController controller = Get.put(
    NativeLanguageController(),
  );

  final Map<String, String> languageFlags = {
    'English': AppImages.englishFlag,
    'Tagalog': AppImages.spanishFlag,
  };

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
          backgroundColor: isDark
              ? AppDarkColors.backgroundColor
              : AppLightColors.backgroundColor,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          title: Text(
            "Native Language",
            style: GoogleFonts.inter(
              color: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: languageFlags.keys.map((language) {
              return Column(
                children: [
                  Obx(
                    () => _LanguageTile(
                      title: language,
                      flagAsset: languageFlags[language]!,
                      isSelected: controller.selectedLanguage.value == language,
                      onTap: () => controller.selectLanguage(language),
                    ),
                  ),
                  SizedBox(height: 15.h),
                ],
              );
            }).toList(),
          ),
        ),
      );
    });
  }
}

class _LanguageTile extends StatelessWidget {
  final String title;
  final String flagAsset;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageTile({
    required this.title,
    required this.flagAsset,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.isDark.value;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        height: 60.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected
                ? AppDarkColors.primaryColor
                : (isDark ? Color(0xFFffffff) : Colors.black12),
            width: 2.w,
          ),
        ),
        child: Row(
          children: [
            // Flag image
            Image.asset(
              flagAsset,
              width: 35.w,
              height: 24.h,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  color: isDark
                      ? AppDarkColors.primaryTextColor
                      : AppLightColors.primaryTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // Selected indicator
            Container(
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppDarkColors.primaryColor
                      : Colors.grey.shade400,
                  width: 2,
                ),
                color: Colors.white,
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppDarkColors.primaryColor,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
