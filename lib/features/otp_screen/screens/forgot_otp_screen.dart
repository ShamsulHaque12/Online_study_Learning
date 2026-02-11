
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
import 'package:online_study/constraints/app_images.dart';
import 'package:online_study/features/otp_screen/controller/forgot_otp_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';
import 'package:pinput/pinput.dart';

class ForgotOtpScreen extends StatelessWidget {
  ForgotOtpScreen({super.key});
  final ForgotOtpController controller = Get.put(ForgotOtpController());

  @override
  Widget build(BuildContext context) {
    final userId = Get.arguments['id'];

    debugPrint('UserID: $userId');

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
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
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
                      "Enter the OTP sent to your email address",
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60.h),
              Center(
                child: Pinput(
                  length: 6,
                  controller: controller.pinController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the OTP';
                    } else if (value.length < 6) {
                      return 'OTP must be 6 digits';
                    }
                    return null;
                  },
                  defaultPinTheme: PinTheme(
                    width: 50.w,
                    height: 54.h,
                    textStyle: TextStyle(
                      fontSize: 20.sp,
                      color: isDark ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppDarkColors.backgroundColor
                          : AppLightColors.backgroundColor,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: isDark ? Colors.white54 : Colors.black54,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              // Text(
              //   "Resend Code",
              //   style: GoogleFonts.inter(
              //     color: isDark ? Colors.white : Color(0xff2C3E50),
              //     fontSize: 14.sp,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              Obx(() {
                return Center(
                  child: TextButton(
                    onPressed: controller.seconds.value == 0
                        ? () => controller.resendCode(context, userId)
                        : null,
                    child: controller.seconds.value == 0
                        ? Text(
                            "Resend Code",
                            style: GoogleFonts.inter(
                              color: isDark ? Colors.white : Color(0xff2C3E50),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : Text(
                            "Resend Code (${controller.seconds.value.toString().padLeft(2, '0')}) Seconds",
                            style: GoogleFonts.inter(
                              color: isDark ? Colors.white54 : Colors.black54,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                );
              }),
              SizedBox(height: 20.h),
              Obx(
                () => controller.isLoading.value
                    ? SpinKitCircle(
                        color: isDark
                            ? AppDarkColors.primaryColor
                            : AppLightColors.primaryColor,
                      )
                    : CustomButton(
                        text: "Verify",
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                            // Proceed with OTP verification logic
                            controller.verifyOtp(context, userId);
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
