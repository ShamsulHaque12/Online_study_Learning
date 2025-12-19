import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../../core/app_colours.dart';
import '../../../core/app_images.dart';
import 'onbording_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void _navigate(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAll(() => OnbordingScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigate(context);
    });

    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      body: SafeArea(
        child: Center(
          child: Image.asset(AppImages.wordflow, height: 150.h, width: 150.w),
        ),
      ),
    );
  }
}
