
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:online_study/survey_screen/screens/servey_signup_account.dart';

import '../../component/custom_widgets/custom_button.dart';
import '../../core/app_colours.dart';
import '../../core/app_images.dart';

class ServeyCreateAccount extends StatelessWidget {
  const ServeyCreateAccount({super.key});

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
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              AppImages.pakhi1,
              height: 200.h,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 15.h),
            Center(
              child: Text(
                "Your personal learning plan is ready!But,you need to create an account to save your progress.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ),
            Spacer(),
            CustomButton(
              text: "Create your account",
              onTap: () {
                Get.to(()=>ServeySignupAccount());
              },
              backgroundColor: AppColors.btnBG,
              textColor: Colors.white,
              borderColor: Colors.transparent,
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
