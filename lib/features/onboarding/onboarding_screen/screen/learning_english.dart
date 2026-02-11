
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/components/custom_button.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_images.dart';
import 'package:online_study/features/onboarding/onboarding_screen/controller/onbording_controller.dart';
import 'package:online_study/features/onboarding/onboarding_screen/screen/remaindar_time.dart';
import 'package:online_study/global/data/works_data.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class LearningEnglish extends StatelessWidget {
  LearningEnglish({super.key});

  final OnbordingController controller = Get.find<OnbordingController>();

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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[400],
                    ),
                    child: Image.asset(
                      AppImages.pencilPutul,
                      width: 100.w,
                      height: 100.h,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      "Why are you learning English?",
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 25.h),

              /// LIST (Expanded + Scroll)
              Expanded(
                child: ListView.builder(
                  itemCount: works.length,
                  itemBuilder: (context, index) {
                    return Obx(() {
                      final isSelected = controller.selectedWork.value == index;

                      final skill = works[index];

                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: GestureDetector(
                          onTap: () => controller.selectWork(index),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 14.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                width: 2,
                                color: isSelected
                                    ? AppDarkColors.primaryColor
                                    : Colors.grey.shade400,
                              ),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  skill["icon"]!,
                                  width: 30.w,
                                  height: 30.h,
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        skill["title"]!,
                                        style: GoogleFonts.inter(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        skill["subtitle"]!,
                                        style: GoogleFonts.inter(
                                          fontSize: 12.sp,
                                          color: isDark
                                              ? Colors.white70
                                              : Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
                  },
                ),
              ),

              /// Button
              CustomButton(
                text: "Continue",
                onPressed: () {
                  if (controller.selectedWork.value == -1) {
                    Get.snackbar(
                      "Selection Required",
                      "Please select a reason for learning English.",
                      backgroundColor: Colors.redAccent,
                      colorText: Colors.white,
                    );
                    return;
                  }
                  Get.to(() => RemaindarTime());
                },
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
    });
  }
}
