
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:online_study/constraints/app_images.dart';
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
      body: Center(child: SvgPicture.asset(AppImages.workFlowTextSVG)),
    );
    });
  }
}
