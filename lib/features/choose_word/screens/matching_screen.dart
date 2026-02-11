
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/components/custom_button_widget.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/choose_word/controller/matching_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class MatchingScreen extends StatelessWidget {
  const MatchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(() {
      final isDark = themeController.isDark.value;

    return GetBuilder<MatchingController>(
      builder: (c) {
        return Scaffold(
          backgroundColor: isDark
              ? AppDarkColors.backgroundColor
              : AppLightColors.backgroundColor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: isDark
                ? AppDarkColors.backgroundColor
                : AppLightColors.backgroundColor,
            leading: IconButton(
              onPressed: Get.back,
              icon: Icon(
                Icons.arrow_back_ios,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            title: Text(
              'Matching Words',
              style: TextStyle(
                color: isDark
                    ? AppDarkColors.primaryTextColor
                    : AppLightColors.primaryTextColor,
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: c.progress,
                  minHeight: 8,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: const AlwaysStoppedAnimation(Colors.orange),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Tap the matching word',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppDarkColors.primaryTextColor
                        : AppLightColors.primaryTextColor,
                  ),
                ),
                SizedBox(height: 16.h),

                // ================= LISTS =================
                Expanded(
                  child: Row(
                    children: [
                      _wordList(
                        words: c.englishWords,
                        onTap: c.selectEnglish,
                        color: c.englishColor,
                        isDark: isDark,
                      ),
                      SizedBox(width: 16.w),
                      _wordList(
                        words: c.filipinoWords,
                        onTap: c.selectFilipino,
                        color: c.filipinoColor,
                        isDark: isDark,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.h),
                CustomButtonWidget(
                  text: c.isLast ? 'Finish' : 'Continue',
                  backgroundColor: AppDarkColors.primaryColor,
                  onTap: c.canContinue
                      ? () {
                          if (c.isLast) {
                            _showDone();
                          } else {
                            c.next();
                          }
                        }
                      : null,
                ),
                SizedBox(height: 20.h),
                // SizedBox(
                //   width: double.infinity,
                //   height: 45.h,
                //   child: ElevatedButton(
                //     onPressed: c.canContinue
                //         ? () {
                //             if (c.isLast) {
                //               _showDone();
                //             } else {
                //               c.next();
                //             }
                //           }
                //         : null,
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.orange,
                //     ),
                //     child: Text(
                //       c.isLast ? 'Finish' : 'Continue',
                //       style: TextStyle(fontSize: 16.sp, color: Colors.white),
                //     ),
                //   ),
                // ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      },
    );
    });
  }

  Widget _wordList({
    required List<String> words,
    required Function(String) onTap,
    required Color Function(String) color,
    required bool isDark,
  }) {
    return Expanded(
      child: ListView.builder(
        itemCount: words.length,
        itemBuilder: (_, i) {
          return GestureDetector(
            onTap: () => onTap(words[i]),
            child: Container(
              height: 70.h,
              margin: EdgeInsets.only(bottom: 12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color(words[i]),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                ),
              ),
              child: Text(
                words[i],
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.black),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showDone() {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.isDark.value;
    Get.dialog(
      AlertDialog(
        backgroundColor: isDark
            ? AppDarkColors.backgroundColor
            : AppLightColors.backgroundColor,
        title: Text(
          'Congratulations 🎉',
          style: GoogleFonts.inter(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: isDark
                ? AppDarkColors.primaryTextColor
                : AppLightColors.primaryTextColor,
          ),
        ),
        content: Text(
          'You completed all levels!',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: isDark
                ? AppDarkColors.primaryTextColor
                : AppLightColors.primaryTextColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              Get.back();
            },
            child: const Text('Back Home'),
          ),
          TextButton(
            onPressed: () {
              Get.find<MatchingController>().reset();
              Get.back();
            },
            child: const Text('Play Again'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
