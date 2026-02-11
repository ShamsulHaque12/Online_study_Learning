
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class ResponseWritting extends StatelessWidget {
  const ResponseWritting({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final langController = Get.find<LanguageController>();
    final data = Get.arguments as Map<String, dynamic>;

    final String rating = data['rating'] ?? '';
    final bool needToImprove = data['need_to_improve'] ?? false;
    final String sampleResponse = data['sample_response'] ?? '';

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
           langController.selectedLanguage[ "Writing Response"] ?? "Writing Response",
            style: GoogleFonts.inter(
              color: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Intro
              Text(
               langController.selectedLanguage[ "Here is the evaluation of your writing based on AI analysis:"] ?? "Here is the evaluation of your writing based on AI analysis:",

                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: isDark
                      ? AppDarkColors.primaryTextColor
                      : AppLightColors.primaryTextColor,
                ),
              ),

              SizedBox(height: 20.h),

              /// Rating
              Text(
                langController.selectedLanguage["Overall Rating"] ?? "Overall Rating",
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? AppDarkColors.primaryTextColor
                      : AppLightColors.primaryTextColor,
                ),
              ),
              SizedBox(height: 6.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: needToImprove
                      ? Colors.orange.withOpacity(0.15)
                      : Colors.green.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  rating.toUpperCase(),
                  style: GoogleFonts.inter(
                    color: needToImprove ? Colors.orange : Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              /// Sample Improved Response
              Text(
                langController.selectedLanguage["Sample Improved Response"] ?? "Sample Improved Response",
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? AppDarkColors.primaryTextColor
                      : AppLightColors.primaryTextColor,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withOpacity(0.05)
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  sampleResponse,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: isDark
                        ? AppDarkColors.primaryTextColor
                        : AppLightColors.primaryTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
