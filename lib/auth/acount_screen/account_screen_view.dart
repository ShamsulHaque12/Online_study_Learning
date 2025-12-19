import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../component/custom_widgets/custom_button.dart';
import '../../core/app_colours.dart';
import '../../survey_screen/screens/survey_first.dart';
import '../signIn_screen/screens/sign_in_screen.dart';

class AccountScreenView extends StatelessWidget {
  const AccountScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(height: 30.h),

            // Already have an account
            Text(
              "Already have an account ?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Color(0xFF212529),
              ),
            ),

            SizedBox(height: 10.h),

            Text(
              "Pick up where you left off.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: isDark ? Colors.white : Color(0xFF212529)),
            ),

            SizedBox(height: 15.h),

            CustomButton(
              text: "Sign In",
              onTap: () {
                Get.to(()=>SignInScreen());
              },
              backgroundColor: AppColors.btnBG,
              textColor: isDark ? Colors.white : Color(0xFF212529),
              borderColor: Colors.transparent,
            ),

            SizedBox(height: 20.h),

            Divider(
              color: Colors.orange,
              thickness: 2,
            ),

            SizedBox(height: 20.h),

            // New to wordflow
            Text(
              "New to wordflow ?",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Color(0xFF212529)),
            ),

            SizedBox(height: 10.h),

            Text(
              "Start learning now.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: isDark ? Colors.white : Color(0xFF212529)),
            ),

            SizedBox(height: 15.h),

            CustomButton(
              text: "Get Start",
              onTap: () {
                Get.to(()=>SurveyFirst());
              },
              backgroundColor: Colors.transparent,
              textColor: AppColors.btnBG,
              borderColor: AppColors.btnBG,
              borderWidth: 2.w,
            ),
          ],
        ),
      ),
    );
  }
}
