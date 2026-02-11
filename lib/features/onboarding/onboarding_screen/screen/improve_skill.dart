
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/components/custom_button.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_images.dart';
import 'package:online_study/features/onboarding/onboarding_screen/controller/onbording_controller.dart';
import 'package:online_study/features/onboarding/onboarding_screen/screen/study_time.dart';
import 'package:online_study/global/data/like_to_improve_data.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class ImproveSkill extends StatelessWidget {
  ImproveSkill({super.key});
  final OnbordingController controller = Get.put(OnbordingController());
  // Skills list with SVG icons

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
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top text + avatar
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
                    "What aspects of English would you like to improve, ${controller.nameController.text}?",
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

            Expanded(
              child: ListView.builder(
                itemCount: likeToImprove.length,
                itemBuilder: (context, index) {
                  return Obx(() {
                    return _buildSkillCard(
                      title: likeToImprove[index]["name"]!,
                      iconPath: likeToImprove[index]["icon"]!,
                      isSelected: controller.selectedImproveSkills.contains(
                        index,
                      ),
                      onTap: () => controller.toggleImproveSkill(index),
                      isDark: isDark,
                    );
                  });
                },
              ),
            ),

            /// Continue Button
            CustomButton(
              text: "Continue",
              onPressed: () {
                if (controller.selectedImproveSkills.isEmpty) {
                  Get.snackbar(
                    "Selection Required",
                    "Please select at least one skill to improve.",
                    backgroundColor: Colors.redAccent,
                    colorText: Colors.white,
                  );
                  return;
                }
                Get.to(() => StudyTime());
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
    });
  }

  /// Skill Card Widget
  Widget _buildSkillCard({
    required String title,
    required String iconPath,
    required bool isSelected,
    required Function onTap,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        margin: EdgeInsets.only(bottom: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(
            color: isSelected
                ? AppDarkColors.primaryColor
                : (isDark ? Colors.grey.shade700 : Colors.grey.shade300),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          child: Row(
            children: [
              SizedBox(
                height: 25.h,
                width: 25.h,
                child: SvgPicture.asset(iconPath, fit: BoxFit.contain),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),

              /// Checkbox UI
              Container(
                height: 20.h,
                width: 20.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: isSelected
                        ? AppDarkColors.primaryColor
                        : Colors.grey.shade400,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          height: 12.h,
                          width: 12.h,
                          decoration: BoxDecoration(
                            color: AppDarkColors.primaryColor,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
