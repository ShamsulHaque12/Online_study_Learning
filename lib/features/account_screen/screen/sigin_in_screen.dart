
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/components/custom_button.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_icons.dart';
import 'package:online_study/constraints/app_images.dart';
import 'package:online_study/features/account_screen/controller/account_screen_controller.dart';
import 'package:online_study/features/account_screen/screen/forgot_password_screen.dart';
import 'package:online_study/route/app_routes.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class SiginInScreen extends StatelessWidget {
  SiginInScreen({super.key});
  final AccountScreenController controller = Get.put(AccountScreenController());

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
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: isDark ? Colors.white : Colors.black,
            ),
            onPressed: () => Get.back(),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Enter Your Details to Sign In',
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
                  "Email",
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: controller.emailController,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (GetUtils.isEmail(value) == false) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: 'Enter Your Email'),
                ),
                SizedBox(height: 16.h),
                Text(
                  "Password",
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: controller.passwordController,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: 'Enter Your Password'),
                  obscureText: true,
                ),
                SizedBox(height: 24.h),
                Obx(
                  () => controller.isLoading.value
                      ? SpinKitCircle(
                          color: isDark
                              ? AppDarkColors.primaryColor
                              : AppLightColors.primaryColor,
                        )
                      : CustomButton(
                          text: 'Sign In',
                          onPressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              controller.loginUser(context);
                            }
                          },
                        ),
                ),
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: () {
                    Get.to(() => ForgotPasswordScreen());
                  },
                  child: Center(
                    child: Text(
                      "Forgot Password",
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppDarkColors.primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                ElevatedButton(
                  onPressed: () {
                    // Google Sign-in
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark
                        ? const Color(0xffEDEDED)
                        : AppLightColors.welButtonBackColor,
                    minimumSize: Size(double.infinity, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      side: BorderSide(
                        color: AppDarkColors.primaryColor,
                        width: 1.5.w,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppIcons.google,
                        width: 30.w,
                        height: 30.h,
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        'Google',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.black : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  void _showPopup(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AppImages.putul, height: 100.h, width: 100.w),
                SizedBox(height: 20.h),
                Text(
                  "Signing you in.....",
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop();
      Get.offAllNamed(AppRoutes.bottomNavScreen);
    });
  }
}
