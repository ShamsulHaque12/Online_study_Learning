
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/components/bg_widget.dart';
import 'package:online_study/components/custom_button.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/account_screen/screen/account_screen.dart';
import 'package:online_study/features/onboarding/onboarding_screen/screen/servey_screen.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() {
    final isDark = themeController.isDark.value;
      return BgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 300.h),

                SizedBox(height: 50.h),

                CustomButton(
                  text: "Get Started",
                  onPressed: () {
                    Get.to(() => ServeyScreen());
                  },
                ),
                SizedBox(height: 20.h),
                // Already Account Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark
                          ? AppDarkColors.welButtonBackColor
                          : AppLightColors.welButtonBackColor,
                      foregroundColor: isDark ? Colors.white : Colors.black,
                      padding: EdgeInsets.symmetric(
                        horizontal: 50.w,
                        vertical: 15.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    onPressed: () {
                      Get.to(() => AccountScreen());
                    },
                    child: Text(
                      "I already have an account",
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: isDark
                            ? AppDarkColors.tealColor
                            : AppLightColors.tealColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    });
  }
}
