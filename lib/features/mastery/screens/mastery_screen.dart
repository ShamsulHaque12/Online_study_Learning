
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_icons.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/features/mastery/controller/mastery_controller.dart';
import 'package:online_study/features/mastery/widgets/lesson_progress_card.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class MasteryScreen extends StatelessWidget {
  MasteryScreen({super.key});
  final MasteryController controller = Get.put(MasteryController());
  final langController = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    controller.getMasteryData();

    return Obx(() {
    final isDark = themeController.isDark.value;
      return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Chapter Progress
          Text(
            langController.selectedLanguage["Chapter"] ?? "Chapter",
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppDarkColors.primaryTextColor
                  : AppLightColors.primaryTextColor,
            ),
          ),
          SizedBox(height: 10.h),

          Row(
            children: [
              SvgPicture.asset(AppIcons.one, height: 20.h, width: 20.w),
              SizedBox(width: 10.w),
              Expanded(
                child: Obx(() {
                  double value = controller.progress.value;
                  int orange = (value * 100).toInt();
                  int gray = 100 - orange;

                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: SizedBox(
                      height: 10.h,
                      child: Row(
                        children: [
                          Expanded(
                            flex: orange,
                            child: Container(color: Colors.orange),
                          ),
                          Expanded(
                            flex: gray,
                            child: Container(color: Colors.grey[300]),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(width: 10.w),
              SvgPicture.asset(AppIcons.two, height: 20.h, width: 20.w),
            ],
          ),

          SizedBox(height: 10.h),
          Obx(() {
            return Text(
              "${controller.pointsToNextChapter.value} points to next Chapter",
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppDarkColors.primaryTextColor
                    : AppLightColors.grayTextColor,
              ),
            );
          }),
          SizedBox(height: 20.h),

          /// Circle Progress Bar
          Center(
            child: Obx(() {
              double value = controller.circleProgress.value;

              return SizedBox(
                height: 150.w,
                width: 150.w,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 150.w,
                      width: 150.w,
                      child: CircularProgressIndicator(
                        value: 1,
                        strokeWidth: 18.w,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isDark
                              ? Color(0xFFCED4DA)
                              : AppDarkColors.grayTextColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 150.w,
                      width: 150.w,
                      child: CircularProgressIndicator(
                        value: value,
                        strokeWidth: 18.w,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppDarkColors.textColors2,
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${(value * 100).toInt()}%",
                          style: GoogleFonts.inter(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w600,
                            color: AppDarkColors.textColors2,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          langController
                              .selectedLanguage["Completed"] ?? "Completed",
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppDarkColors.textColors2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
          SizedBox(height: 20.h),
          Center(
            child: Obx(() {
              final percent = (controller.circleProgress.value * 100).toInt();
              return RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    color: isDark
                        ? AppDarkColors.primaryTextColor
                        : AppLightColors.primaryTextColor,
                  ),
                  children: [
                   TextSpan(text: "You've mastered "),
                    TextSpan(
                      text: "$percent%",
                      style: TextStyle(
                        color: AppDarkColors.textColors2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const TextSpan(text: " of your learning journey!"),
                  ],
                ),
              );
            }),
          ),
          SizedBox(height: 20.h),

          /// Sections List
          Text(
           langController.selectedLanguage["Sections"] ?? "Sections",
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppDarkColors.primaryTextColor
                  : AppLightColors.primaryTextColor,
            ),
          ),
          Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: controller.sections.map((section) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: LessonProgressCard(section: section),
                );
              }).toList(),
            );
          }),
          SizedBox(height: 20.h),
        ],
      ),
    );
    });
  }
}
