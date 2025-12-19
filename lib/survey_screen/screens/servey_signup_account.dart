
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:online_study/survey_screen/screens/servey_welcome.dart';

import '../../component/custom_widgets/custom_button.dart';
import '../../component/custom_widgets/custom_text_field.dart';
import '../../core/app_colours.dart';
import '../../core/app_images.dart';
import '../controller/servey_controller.dart';

class ServeySignupAccount extends StatelessWidget {
  ServeySignupAccount({super.key});
  final ServeyController controller = Get.put(ServeyController());
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Profile + Text Row
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 40.r,
                          backgroundColor: Colors.grey[400],
                          backgroundImage: AssetImage(AppImages.putul),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            "What is your email address and Password",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      textEditingController: controller.emailController,
                      hintText: "Enter your Email",
                      hintTextColor: isDark ? Colors.grey : Colors.grey,
                      fillColor: Colors.transparent,
                      textColor: isDark ? Colors.white : Colors.black,
                      borderSide: BorderSide(
                        color: isDark ? Colors.white : Colors.black,
                        width: 1.w,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    CustomTextField(
                      textEditingController: controller.passwordController,
                      hintText: "Enter your Password",
                      hintTextColor: isDark ? Colors.grey : Colors.grey,
                      fillColor: Colors.transparent,
                      textColor: isDark ? Colors.white : Colors.black,
                      borderSide: BorderSide(
                        color: isDark ? Colors.white : Colors.black,
                        width: 1.w,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    CustomTextField(
                      textEditingController: controller.confirmPasswordController,
                      hintText: "Enter your Confirm Password",
                      hintTextColor: isDark ? Colors.grey : Colors.grey,
                      fillColor: Colors.transparent,
                      textColor: isDark ? Colors.white : Colors.black,
                      borderSide: BorderSide(
                        color: isDark ? Colors.white : Colors.black,
                        width: 1.w,
                      ),
                    ),

                    /// Continue Button

                  ],
                ),
              ),
            ),
          ),
          CustomButton(
            text: "Continue",
            onTap: () {
              Get.to(() => ServeyWelcome());
            },
            backgroundColor: AppColors.btnBG,
            textColor: Colors.white,
            borderColor: Colors.transparent,
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
