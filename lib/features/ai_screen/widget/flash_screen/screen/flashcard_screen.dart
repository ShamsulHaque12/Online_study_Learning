
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../component/custom_widgets/custom_button.dart';
import '../../../../../core/app_colours.dart';
import '../../../../../core/app_images.dart';
import 'flip_card_screen.dart';

class FlashcardScreen extends StatelessWidget {
  const FlashcardScreen({super.key});

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
          "FlashCard",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Saving Words",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.bgLight : Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Center(
              child: Image.asset(
                AppImages.pencil_putul,
                height: 200.h,
                width: 200.w,
              ),
            ),
            SizedBox(height: 15.h),
            Center(
              child: Text(
                "Start Your Learning Journey",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.grammer,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Center(
              child: Text(
                "Search for any word to see its meaning, pronunciation,and examples.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: isDark ? AppColors.bgLight : Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            CustomButton(
              text: "Continue",
              onTap: () {
                Get.to(()=>FlipCardScreen());
              },
              backgroundColor: AppColors.btnBG,
              borderColor: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
