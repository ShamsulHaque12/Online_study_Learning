import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../../component/custom_widgets/custom_button.dart';
import '../../../core/app_colours.dart';
import '../controller/forgot_password_controller.dart';
import 'forgot_new_password.dart';

class ForgotOtpScreen extends StatelessWidget {
  final ForgotPasswordController controller = Get.put(
    ForgotPasswordController(),
  );
  final String? email;
  ForgotOtpScreen({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Enter Your Details",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : AppColors.lightText,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Center(
              child: Text(
                'Enter verification code',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : AppColors.lightText,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Center(
              child: Text(
                "The verification code has been sent to \n${email.toString()} \nPlease enter the code to continue.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: isDark ? Colors.white : AppColors.lightText,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Center(
              child: Pinput(
                length: 6,
                controller: controller.pinController,
                defaultPinTheme: PinTheme(
                  width: 50.w,
                  height: 54.h,
                  textStyle: TextStyle(
                    fontSize: 20.sp,
                    color: isDark ? Colors.white : AppColors.lightText,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.bgDark : AppColors.bgLight,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: isDark ? Colors.white : Colors.grey),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Obx(() {
              return Center(
                child: TextButton(
                  onPressed: controller.seconds.value == 0
                      ? controller.onResendCode
                      : null,
                  child: controller.seconds.value == 0
                      ? Text(
                          "Resend Code",
                          style: TextStyle(
                            color: isDark ? Colors.white : AppColors.lightText,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      : Text(
                          "Resend Code (00:${controller.seconds.value.toString().padLeft(2, '0')})",
                          style: TextStyle(
                            color: isDark ? Colors.white : AppColors.lightText,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              );
            }),

            SizedBox(height: 20.h),

            SizedBox(height: 20),
            CustomButton(
              text: "Continue",
              onTap: () {
                Get.to(() => ForgotNewPassword());
              },
              backgroundColor: AppColors.btnBG,
              textColor: Colors.white,
              borderColor: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
