
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/components/custom_button.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_images.dart';
import 'package:online_study/features/onboarding/onboarding_screen/screen/creat_account.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class WelcomeAccount extends StatelessWidget {
  const WelcomeAccount({super.key});

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
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              AppImages.pakhi,
              height: 200.h,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 15.h),
            Center(
              child: Text(
                "Your personal learning plan is ready!But,you need to create an account to save your progress.",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ),
            Spacer(),
            CustomButton(
              text: "Create your account",
              onPressed: () {
                Get.to(() => CreatAccount());
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
