
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:online_study/components/custom_button_widget.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class ResultPopup extends StatelessWidget {
  final int score;
  final int total;
  final VoidCallback onTryAgain;

  const ResultPopup({
    super.key,
    required this.score,
    required this.total,
    required this.onTryAgain,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    String message;
    String emoji;

    if (score == total) {
      message = 'Perfect Score!';
      emoji = '🎉';
    } else if (score >= total * 0.7) {
      message = 'Great Job!';
      emoji = '👏';
    } else {
      message = 'Keep Practicing!';
      emoji = '💪';
    }

    return Obx(() {
    final isDark = themeController.isDark.value;
      return Dialog(
      backgroundColor: isDark
          ? AppDarkColors.backgroundColor
          : AppLightColors.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      child: Container(
        padding: EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: TextStyle(fontSize: 80.sp)),
            SizedBox(height: 18.h),
            Text(
              'Quiz Complete!',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: isDark
                    ? AppDarkColors.primaryTextColor
                    : AppLightColors.primaryTextColor,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              '$score/$total',
              style: TextStyle(
                fontSize: 56,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              message,
              style: TextStyle(
                fontSize: 18.sp,
                color: isDark
                    ? AppDarkColors.primaryTextColor
                    : AppLightColors.primaryTextColor,
              ),
            ),
            SizedBox(height: 24.h),
            CustomButtonWidget(
              text: "Try Again",
              onTap: onTryAgain,
              backgroundColor: Colors.green,
            ),
            SizedBox(height: 16.h),
            CustomButtonWidget(
              text: "Exit",
              onTap: () {
                Get.back();
                Get.back();
              },
              backgroundColor: Colors.red,
            ),
          ],
        ),
      ),
    );
    });
  }
}
