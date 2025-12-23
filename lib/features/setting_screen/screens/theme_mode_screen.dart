import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/app_colours.dart';
import '../../../theme/app_theme/theme_controller.dart';

class ThemeModeScreen extends StatelessWidget {
  final ThemeController themeController = Get.find();
  ThemeModeScreen({super.key});

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
          child: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          "Theme Mode",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),

            // Card Container for System Theme
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              color: isDark ? AppColors.containerdark : AppColors.containerBG,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Use System Theme",
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Obx(
                      () => CupertinoSwitch(
                        activeColor: Colors.blue,
                        value:
                            themeController.themeMode.value == ThemeMode.system,
                        onChanged: (value) {
                          if (value) {
                            themeController.changeTheme(ThemeMode.system);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 15.h),

            // Card Container for Dark Mode
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              color: isDark ? AppColors.containerdark : AppColors.containerBG,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Dark Mode",
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Obx(
                      () => CupertinoSwitch(
                        activeColor: Colors.blue,
                        value:
                            themeController.themeMode.value == ThemeMode.dark,
                        onChanged: (value) {
                          if (value) {
                            themeController.changeTheme(ThemeMode.dark);
                          } else {
                            themeController.changeTheme(ThemeMode.light);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 25.h),
          ],
        ),
      ),
    );
  }
}
