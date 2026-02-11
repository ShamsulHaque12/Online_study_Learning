import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/splash/controller/splash_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    Get.find<SplashController>();

    return Obx(() {
      final isDark = themeController.isDark.value;

      return Scaffold(
        backgroundColor:
            isDark ? AppDarkColors.backgroundColor : AppLightColors.backgroundColor,
        body: Center(
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [
                Color(0xFFFF512F), // Red
                Color(0xFFF09819), // Orange
                Color(0xFFFF512F), // Red
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: Text(
              'Online Study\nLearning',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 42.sp,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 1.2,
                height: 1.2,
              ),
            ),
          ),
        ),
      );
    });
  }
}
