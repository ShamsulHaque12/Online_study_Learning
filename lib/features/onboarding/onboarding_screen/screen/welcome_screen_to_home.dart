
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:online_study/components/custom_button.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_images.dart';
import 'package:online_study/features/account_screen/screen/sigin_in_screen.dart';
import 'package:online_study/features/onboarding/onboarding_screen/controller/onbording_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class WelcomeScreenToHome extends StatelessWidget {
  WelcomeScreenToHome({super.key});
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
        // leading: GestureDetector(
        //   onTap: () => Navigator.pop(context),
        //   child: Icon(
        //     Icons.arrow_back_ios,
        //     color: isDark ? Colors.white : Colors.black,
        //   ),
        // ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[800] : Colors.grey[200],
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: isDark
                      ? AppDarkColors.borderColor
                      : AppLightColors.borderColor,
                  width: 1.w,
                ),
              ),
              child: Text(
                "Welcome, ${controller.nameController.text}! Your profile has been successfully created.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Image.asset(
              AppImages.pakhi,
              height: 200.h,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
            Spacer(),
            CustomButton(
              text: "Go to Home",
              onPressed: () {
                // Get.offAllNamed(AppRoutes.bottomNavScreen);
                Get.to(() => SiginInScreen());
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
