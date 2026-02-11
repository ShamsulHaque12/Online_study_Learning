
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/components/custom_button.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/account_screen/controller/forgot_password_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class NewForgotPasswordScreen extends StatelessWidget {
  NewForgotPasswordScreen({super.key});
  final ForgotPasswordController controller = Get.put(
    ForgotPasswordController(),
  );

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final accessToken = Get.arguments['accessToken'];
    return Obx(() {
    final isDark = themeController.isDark.value;
      return Scaffold(
        backgroundColor: isDark
            ? AppDarkColors.backgroundColor
            : AppLightColors.backgroundColor,
        appBar: AppBar(),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Enter Your New Password to Sign In',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  "New Password",
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: controller.newPasswordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your new password';
                    } else if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'New Password'),
                ),
                SizedBox(height: 16.h),
                Text(
                  "Confirm Password",
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: controller.confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    } else if (value != controller.newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                ),
                SizedBox(height: 24.h),
                Obx(
                  () => controller.passwordResetLoading.value
                      ? SpinKitCircle(
                          color: isDark
                              ? AppDarkColors.primaryColor
                              : AppLightColors.primaryColor,
                        )
                      : CustomButton(
                          text: 'Submit',
                          onPressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              controller.resetPassword(context, accessToken);
                            }
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
