
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/components/custom_button.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_images.dart';
import 'package:online_study/features/onboarding/onboarding_screen/controller/onbording_controller.dart';
import 'package:online_study/features/onboarding/onboarding_screen/screen/welcome_account.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class ServeyHelp extends StatelessWidget {
  ServeyHelp({super.key});
  final OnbordingController controller = Get.find<OnbordingController>();

  final List<Map<String, String>> levels = [
    {
      "title": "Learning English for the first time",
      "subtitle": "Start from scratch!",
      "icon": AppImages.pencilPutul,
    },
    {
      "title": "Already know some English?",
      "subtitle": "Answer some questions to find your level!",
      "icon": AppImages.pencilPutul,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(() {
      final isDark = themeController.isDark.value;
    return Scaffold(
      backgroundColor: isDark
          ? AppDarkColors.backgroundColor
          : AppLightColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: isDark
            ? AppDarkColors.backgroundColor
            : AppLightColors.backgroundColor,
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
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[400],
                  ),
                  child: Image.asset(
                    AppImages.pencilPutul,
                    width: 100.w,
                    height: 100.h,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    "Help us find your level",
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Obx(
              () => Column(
                children: List.generate(levels.length, (index) {
                  final skill = levels[index];
                  final isSelected = controller.selectedLabel.value == index;

                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: GestureDetector(
                      onTap: () => controller.selectlabel(index),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 14.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: isSelected
                                ? AppDarkColors.primaryColor
                                : (isDark
                                      ? Colors.grey.shade700
                                      : Colors.grey.shade300),
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              skill["icon"]!,
                              width: 35.w,
                              height: 50.h,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    skill["title"]!,
                                    style: GoogleFonts.inter(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: isDark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  Text(
                                    skill["subtitle"]!,
                                    style: GoogleFonts.inter(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: isDark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            Spacer(),
            CustomButton(
              text: "Continue",
              onPressed: () {
                if (controller.selectedLabel.value == -1) {
                  Get.snackbar(
                    "Selection Required",
                    "Please select an option to continue.",
                    backgroundColor: Colors.redAccent,
                    colorText: Colors.white,
                  );
                  return;
                }
                Get.to(() => WelcomeAccount());
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
    });
  }
}
