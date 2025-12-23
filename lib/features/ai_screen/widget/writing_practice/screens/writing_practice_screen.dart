
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../component/custom_widgets/custom_button.dart';
import '../../../../../component/custom_widgets/custom_text_field.dart';
import '../../../../../core/app_colours.dart';
import '../controller/writting_controller.dart';

class WritingPracticeScreen extends StatelessWidget {
  final WrittingController controller = Get.put(WrittingController());
  WritingPracticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          "Writing Practice",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Practice your Tagalog writing skills",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.bgLight : Colors.black,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Writing Prompt",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.bgLight : Colors.black,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              "Write about your favorite Filipino dish and why you like it.",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: isDark ? AppColors.bgLight : AppColors.borderLine,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Your Response",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.bgLight : Colors.black,
              ),
            ),
            SizedBox(height: 6.h),
            CustomTextField(
              textEditingController: controller.promtController,
              hintText: "Write your response here...",
              hintTextColor: isDark ? AppColors.bgLight : AppColors.borderLine,
              fillColor: Colors.transparent,
              borderSide: BorderSide(
                color: isDark ? AppColors.bgLight : AppColors.borderLine,
                width: 1.w,
              ),
              maxLines: 5,
            ),
            SizedBox(height: 6.h),
            Text(
              "0 characters • Take your time and write naturally",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: isDark ? AppColors.bgLight : Color(0xFF495057),
              ),
            ),
            SizedBox(height: 20.h),
            CustomButton(
              text: "Continue",
              onTap: () {},
              backgroundColor: AppColors.btnBG,
              borderColor: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
