
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../component/custom_widgets/custom_button.dart';
import '../../../component/custom_widgets/custom_text_field.dart';
import '../../../core/app_colours.dart';
import '../../../core/app_icons.dart';
import '../../../core/app_images.dart';
import '../../../features/splash_screen/screens/onbording_screen.dart';
import '../../../navigation_bar/nav_bar_screen.dart';
import '../../forgot_screen/screens/forgot_gmail.dart';
import '../controller/sign_in_controller.dart';

class SignInScreen extends StatelessWidget {
  final SignInController controller = Get.put(SignInController());

  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
        leading: GestureDetector(
          onTap: () {
            Get.to(() => OnbordingScreen());
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
            Text(
              "Email",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : AppColors.lightText,
              ),
            ),
            SizedBox(height: 8.h),
            CustomTextField(
              hintText: "Enter email",
              textEditingController: controller.emailController,
              fillColor: Colors.transparent,
              hintTextColor: isDark ? Colors.white : AppColors.lightText,
              textColor: isDark ? Colors.white : AppColors.lightText,
              suffixIcon: Icon(
                Icons.email_outlined,
                color: isDark ? Colors.white : AppColors.lightText,
              ),
              borderSide: BorderSide(
                color: isDark ? Colors.white : AppColors.lightText,
                width: 1.w,
              ),
            ),
            SizedBox(height: 15.h),
            Text(
              "Password",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : AppColors.lightText,
              ),
            ),
            SizedBox(height: 8.h),
            CustomTextField(
              textEditingController: controller.passwordController,
              fillColor: Colors.transparent,
              hintText: "Enter password",
              hintTextColor: isDark ? Colors.white : AppColors.lightText,
              textColor: isDark ? Colors.white : AppColors.lightText,
              borderSide: BorderSide(
                color: isDark ? Colors.white : AppColors.lightText,
                width: 1.w,
              ),
              isPassword: true,
            ),
            SizedBox(height: 20.h),
            CustomButton(
              text: "Sign In",
              onTap: () => _showPopup(context),
              backgroundColor: AppColors.btnBG,
              textColor: Colors.white,
              borderColor: Colors.transparent,
            ),
            SizedBox(height: 15.h),
            GestureDetector(
              onTap: () {
                Get.to(() => ForgotGmail());
              },
              child: Center(
                child: Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.btnBG : AppColors.lightText,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.h),
            CustomButton(
              text: "Google",
              onTap: () {},
              backgroundColor: AppColors.btnwhite.withAlpha(150),
              suffixIcon: SvgPicture.asset(
                AppIcons.google,
                height: 25.h,
                width: 25.w,
              ),
              textColor: AppColors.btnBG,
              borderWidth: 1.w,
              borderColor: AppColors.btnBG,
            ),
          ],
        ),
      ),
    );
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
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.lightText,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    // 2 সেকেন্ড পরে popup close করে HomeScreen navigate
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop();
      Get.off(() => NavBarScreen());
    });
  }
}
