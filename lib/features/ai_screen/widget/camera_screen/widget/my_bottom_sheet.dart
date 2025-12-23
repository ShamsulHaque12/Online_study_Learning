import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../component/custom_widgets/custom_button.dart';
import '../../../../../core/app_colours.dart';
import '../../../../../core/app_icons.dart';
import '../controller/tts_controller.dart';

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final TtsController ttsController = Get.put(TtsController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.bgDark : AppColors.bgLight,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Language Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => CustomButton(
                height: 28.h,
                width: MediaQuery.sizeOf(context).width * 0.20,
                text: "ENG",
                onTap: () => ttsController.changeLanguage("ENG"),
                backgroundColor: ttsController.language.value == "ENG"
                    ? AppColors.grammer
                    : AppColors.borderLine,
                borderColor: Colors.transparent,
              )),
              SizedBox(width: 6.w),
              SvgPicture.asset(AppIcons.exchange, height: 22.h, width: 22.w),
              SizedBox(width: 6.w),
              Obx(() => CustomButton(
                height: 28.h,
                width: MediaQuery.sizeOf(context).width * 0.20,
                text: "TAG",
                onTap: () => ttsController.changeLanguage("TAG"),
                backgroundColor: ttsController.language.value == "TAG"
                    ? AppColors.grammer
                    : AppColors.borderLine,
                borderColor: Colors.transparent,
              )),
            ],
          ),
          SizedBox(height: 10.h),

          // Word, Pronunciation & Icons
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(
                    ttsController.word.value,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.bgLight : Colors.black,
                    ),
                  )),
                  SizedBox(height: 5.h),
                  Obx(() => Text(
                    ttsController.pronunciation.value,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.bgLight : Colors.black,
                    ),
                  )),
                ],
              ),
              SizedBox(width: 20.w),
              SvgPicture.asset(AppIcons.bookmark, height: 25.h, width: 25.w),
              SizedBox(width: 20.w),
              GestureDetector(
                onTap: () => ttsController.speak(ttsController.meaning.value),
                child: SvgPicture.asset(AppIcons.sound,
                    height: 25.h, width: 25.w),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color(0xFFA5D8FF),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  "Noun",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Divider(
            thickness: 1,
            color: isDark ? AppColors.bgLight : Colors.black,
          ),
          SizedBox(height: 5.h),

          // Meaning
          Row(
            children: [
              SvgPicture.asset(
                AppIcons.book,
                height: 20.h,
                width: 20.w,
                color: isDark ? AppColors.bgLight : Colors.black,
              ),
              SizedBox(width: 10.w),
              Text(
                "Meaning",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.bgLight : Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Obx(() => Text(
            ttsController.meaning.value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: isDark ? AppColors.borderLine : Colors.black,
            ),
          )),
          SizedBox(height: 5.h),
          Text(
            "OR",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.bgLight : Colors.black,
            ),
          ),
          SizedBox(height: 5.h),
          Obx(() => Text(
            ttsController.example.value,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: isDark ? AppColors.borderLine : Colors.black,
            ),
          )),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
