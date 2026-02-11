
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/components/custom_button.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_images.dart';
import 'package:online_study/features/onboarding/onboarding_screen/controller/onbording_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class CreatAccount extends StatefulWidget {
  const CreatAccount({super.key});

  @override
  State<CreatAccount> createState() => _CreatAccountState();
}

class _CreatAccountState extends State<CreatAccount> {
  final OnbordingController controller = Get.find<OnbordingController>();

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final formKey = GlobalKey<FormState>();


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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Header
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[400],
                      ),
                      child: Image.asset(
                        AppImages.pencilPutul,
                        width: 100.w,
                        height: 100.h,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        "What is your email address and password?",
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 25.h),

                /// Email
                Text(
                  'Email Address',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: controller.emailController,
                  style: TextStyle(color: isDark ? Colors.white : Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (GetUtils.isEmail(value) == false) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                  ),
                ),

                SizedBox(height: 20.h),

                /// Password
                Text(
                  'Password',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: controller.passwordController,
                  style: TextStyle(color: isDark ? Colors.white : Colors.black),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter your password',
                  ),
                ),

                SizedBox(height: 20.h),

                /// Confirm Password
                Text(
                  'Confirm Password',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: controller.confirmPasswordController,
                  style: TextStyle(color: isDark ? Colors.white : Colors.black),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != controller.passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter your confirm password',
                  ),
                ),

                SizedBox(height: 30.h),
                Obx(
                  () => controller.isLoading.value
                      ? SpinKitCircle(
                          color: isDark
                              ? AppDarkColors.primaryColor
                              : AppLightColors.primaryColor,
                        )
                      : CustomButton(
                          text: 'Create Account',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              controller.createAccount(context);
                            }
                            // Get.to(() => OtpScreen());
                          },
                        ),
                ),
                SizedBox(height: 30.h),

                /// OR Divider
                // Row(
                //   children: [
                //     const Expanded(child: Divider()),
                //     Padding(
                //       padding: EdgeInsets.symmetric(horizontal: 10.w),
                //       child: Text(
                //         'OR Sign Up',
                //         style: GoogleFonts.inter(
                //           fontSize: 14.sp,
                //           fontWeight: FontWeight.w500,
                //           color: isDark ? Colors.white70 : Colors.black54,
                //         ),
                //       ),
                //     ),
                //     const Expanded(child: Divider()),
                //   ],
                // ),

                // SizedBox(height: 25.h),

                // /// Google Button
                // ElevatedButton(
                //   onPressed: () {
                //     // Google Sign-in
                //   },
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: isDark
                //         ? const Color(0xffEDEDED)
                //         : AppLightColors.welButtonBackColor,
                //     minimumSize: Size(double.infinity, 50.h),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(16.r),
                //       side: BorderSide(
                //         color: AppDarkColors.primaryColor,
                //         width: 1.5.w,
                //       ),
                //     ),
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       SvgPicture.asset(
                //         AppIcons.google,
                //         width: 30.w,
                //         height: 30.h,
                //       ),
                //       SizedBox(width: 16.w),
                //       Text(
                //         'Google',
                //         style: GoogleFonts.inter(
                //           fontSize: 16.sp,
                //           fontWeight: FontWeight.w600,
                //           color: isDark ? Colors.black : Colors.black,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
    });
  }
}
