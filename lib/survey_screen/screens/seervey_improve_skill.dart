import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:online_study/survey_screen/screens/servey_study_time.dart';
import '../../component/custom_widgets/custom_button.dart';
import '../../core/app_colours.dart';
import '../../core/app_images.dart';
import '../controller/servey_controller.dart';

class SeerveyImproveSkill extends StatelessWidget {
  final ServeyController controller = Get.put(ServeyController());
  SeerveyImproveSkill({super.key});

  // Skills list with SVG icons
  final List<Map<String, String>> skills = [
    {"name": "All Skill", "icon": "assets/icons/skill.svg"},
    {"name": "Speaking", "icon": "assets/icons/spking.svg"},
    {"name": "Writing", "icon": "assets/icons/writing.svg"},
    {"name": "Listening", "icon": "assets/icons/lisiting.svg"},
    {"name": "Grammar", "icon": "assets/icons/gramar.svg"},
    {"name": "Vocabulary", "icon": "assets/icons/vocobalary.svg"},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
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
                CircleAvatar(
                  radius: 40.r,
                  backgroundImage: AssetImage(AppImages.putul),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    "What aspects of English would you like to improve, ${controller.nameController.text}?",
                    style: TextStyle(
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
                itemCount: skills.length,
                itemBuilder: (context, index) {
                  return Obx(() {
                    return _buildSkillCard(
                      title: skills[index]["name"]!,
                      iconPath: skills[index]["icon"]!,
                      isSelected: controller.selectedImproveSkills.contains(index),
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
              onTap: () {
                Get.to(()=>ServeyStudyTime());
              },
              backgroundColor: AppColors.btnBG,
              textColor: Colors.white,
              borderColor: Colors.transparent,
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
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
                ? AppColors.btnBG
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
                  style: TextStyle(
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
                    color: isSelected ? AppColors.btnBG : Colors.grey.shade400,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Center(
                  child: Container(
                    height: 12.h,
                    width: 12.h,
                    decoration: BoxDecoration(
                      color: AppColors.btnBG,
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
