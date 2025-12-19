import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../component/custom_widgets/custom_button.dart';
import '../../../component/custom_widgets/custom_text_field.dart';
import '../../../core/app_colours.dart';
import '../controller/forgot_password_controller.dart';
import 'forgot_otp_screen.dart';

class ForgotGmail extends StatelessWidget {
  final ForgotPasswordController controller = Get.put(ForgotPasswordController());
  ForgotGmail({super.key});

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
              textEditingController: controller.gmailController,
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
            SizedBox(height: 20.h),
            CustomButton(
              text: "Continue",
              onTap: (){
                Get.to(()=>ForgotOtpScreen(
                  email: controller.gmailController.text,
                ));
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
