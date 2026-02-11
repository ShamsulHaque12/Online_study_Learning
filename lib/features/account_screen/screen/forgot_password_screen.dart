
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/components/custom_button.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/account_screen/controller/forgot_password_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final ForgotPasswordController controller = Get.put(
    ForgotPasswordController(),
  );

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() {
    final isDark = themeController.isDark.value;
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            "Enter Your Details",
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: isDark ? Color(0xffFFFFFF) : Color(0xff212529),
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                Text(
                  "Forget Password",
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  style: TextStyle(color: isDark ? Colors.white : Colors.black),
                  controller: controller.emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!GetUtils.isEmail(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: 'Email'),
                ),
                SizedBox(height: 20.h),
                Text(
                  "Enter your email address to receive a link to reset your password.",
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 30.h),
                Obx(
                  () => controller.emailSubmitLoading.value
                      ? SpinKitCircle(
                          color: isDark
                              ? AppDarkColors.primaryColor
                              : AppLightColors.primaryColor,
                        )
                      : CustomButton(
                          text: "Submit",
                          onPressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              controller.submitForgotPassword(context);
                              //  Get.to(() => ForgotOtpScreen());
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
