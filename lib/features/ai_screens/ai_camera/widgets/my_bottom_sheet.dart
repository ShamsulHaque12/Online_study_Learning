
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/ai_screens/ai_camera/controller/ai_camera_controller.dart';
import 'package:online_study/features/ai_screens/ai_dictionary/controller/ai_dictionary_controller.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class MyBottomSheet extends StatelessWidget {
  MyBottomSheet({super.key});
  final controller = Get.find<AiCameraController>();
  final AiDictionaryController aiDictionaryController = Get.put(AiDictionaryController());
  final langController = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() {
    final isDark = themeController.isDark.value;
      return SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: isDark
                  ? AppDarkColors.backgroundColor
                  : AppLightColors.backgroundColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// top drag indicator
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    margin: EdgeInsets.only(bottom: 15.h),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                SizedBox(height: 10.h),

                /// ✅ RESULT
                Obx(() {
                  final data = controller.cameraData.value?.data; // corrected

                  if (data == null) return const SizedBox();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            data.word ?? "",
                            style: GoogleFonts.inter(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? AppDarkColors.primaryTextColor
                                  : AppLightColors.primaryTextColor,
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Obx(
                          () => GestureDetector(
                            onTap: aiDictionaryController.isBookmarked.value
                                ? null // 🚫 disabled
                                : () {
                                    aiDictionaryController.saveDataToDatabase();
                                  },
                            child: Container(
                              padding: EdgeInsets.all(6.w),
                              decoration: BoxDecoration(
                                color: aiDictionaryController.isBookmarked.value
                                    ? AppDarkColors.primaryColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Image.asset(
                                "assets/images/bookmark.png",
                                height: 20.h,
                                width: 20.w,
                                color: aiDictionaryController.isBookmarked.value
                                    ? Colors.white
                                    : null,
                              ),
                            ),
                          ),
                        ),
                          SizedBox(width: 20.w),
                          GestureDetector(
                            onTap: () {
                              controller.speakWord(data.word ?? "");
                            },
                            child: Image.asset(
                              "assets/images/sounds.png",
                              height: 20.h,
                              width: 20.w,
                            ),
                          ),

                          Spacer(),
                          // Container(
                          //   padding: EdgeInsets.all(5),
                          //   decoration: BoxDecoration(
                          //     color: Color(0xFFA5D8FF),
                          //     borderRadius: BorderRadius.circular(8.r),
                          //   ),
                          //   child: Text(
                          //     "Noun", // optionally, tumi data.language use korte paro
                          //     style: TextStyle(
                          //       fontSize: 14.sp,
                          //       fontWeight: FontWeight.w600,
                          //       color: Colors.black,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),

                      SizedBox(height: 5.h),

                      Text(
                        "/${data.syllables ?? ""}/",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: isDark
                              ? AppDarkColors.primaryTextColor
                              : AppLightColors.primaryTextColor,
                        ),
                      ),

                      Divider(
                        thickness: 1,
                        color: isDark
                            ? AppDarkColors.iconColor
                            : AppLightColors.iconeColor,
                      ),

                      SizedBox(height: 10.h),

                      Row(
                        children: [
                          Image.asset(
                            "assets/images/book.png",
                            height: 20.h,
                            width: 20.w,
                            color: isDark
                                ? AppDarkColors.primaryTextColor
                                : AppLightColors.primaryTextColor,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            langController.selectedLanguage["Meaning"] ?? "Meaning",
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? AppDarkColors.primaryTextColor
                                  : AppLightColors.primaryTextColor,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 6.h),

                      if (data.meanings != null)
                        ...data.meanings!.map(
                          (m) => Text(
                            "• $m",
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              color: isDark
                                  ? AppDarkColors.primaryTextColor
                                  : AppLightColors.primaryTextColor,
                            ),
                          ),
                        ),

                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/light.png",
                            height: 20.h,
                            width: 20.w,
                            color: isDark
                                ? AppDarkColors.primaryTextColor
                                : AppLightColors.primaryTextColor,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            langController.selectedLanguage["Example Sentences"] ?? "Example Sentences",
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? AppDarkColors.primaryTextColor
                                  : AppLightColors.primaryTextColor,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 6.h),
                      Text(
                        data.englishSentence ?? "",
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: isDark
                              ? AppDarkColors.primaryTextColor
                              : AppLightColors.primaryTextColor,
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      );
    });
  }
}
