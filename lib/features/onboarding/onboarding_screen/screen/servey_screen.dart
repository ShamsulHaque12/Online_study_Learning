
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_study/components/custom_button.dart';
import 'package:online_study/constraints/app_images.dart';
import 'package:online_study/route/app_routes.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class ServeyScreen extends StatelessWidget {
  const ServeyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(() {
      final isDark = themeController.isDark.value;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            isDark
                ? Image.asset(AppImages.onboarding1Dark)
                : Image.asset(AppImages.onboarding1Light),
            // Image.asset(AppImages.onboarding1Light),
            Spacer(),
            CustomButton(
              text: "Continue",
              onPressed: () {
                Get.toNamed(AppRoutes.onboardingNameScreen);
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
    });
  }
}
