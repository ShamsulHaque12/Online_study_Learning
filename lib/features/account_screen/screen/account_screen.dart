
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/components/custom_button.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/account_screen/screen/sigin_in_screen.dart';
import 'package:online_study/features/onboarding/onboarding_screen/screen/servey_screen.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});
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
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30.h),

              // Already have an account
              Text(
                "Already have an account ?",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Color(0xFF212529),
                ),
              ),

              SizedBox(height: 10.h),

              Text(
                "Pick up where you left off.",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: isDark ? Colors.white : Color(0xFF212529),
                ),
              ),

              SizedBox(height: 15.h),

              CustomButton(
                text: "Sign IN",
                onPressed: () {
                  Get.to(() => SiginInScreen());
                },
              ),

              SizedBox(height: 20.h),

              Divider(color: Colors.orange, thickness: 2),

              SizedBox(height: 20.h),

              // New to wordflow
              Text(
                "New to wordflow ?",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Color(0xFF212529),
                ),
              ),

              SizedBox(height: 10.h),

              Text(
                "Start learning now.",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: isDark ? Colors.white : Color(0xFF212529),
                ),
              ),

              SizedBox(height: 20.h),

              ElevatedButton(
                onPressed: () {
                  Get.to(() => ServeyScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark
                      ? AppDarkColors.backgroundColor
                      : AppLightColors.backgroundColor,
                  minimumSize: Size(double.infinity, 50.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    side: BorderSide(
                      color: isDark
                          ? AppDarkColors.primaryColor
                          : AppLightColors.primaryColor,
                      width: 2.w,
                    ),
                  ),
                ),
                child: Text(
                  "Get Started",
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppDarkColors.primaryColor
                        : AppLightColors.primaryColor,
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
