
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:online_study/survey_screen/screens/seervey_improve_skill.dart';

import '../../component/custom_widgets/custom_button.dart';
import '../../core/app_colours.dart';
import '../../core/app_images.dart';
import '../controller/servey_controller.dart';

class SurveySkill extends StatelessWidget {
  SurveySkill({super.key});

  final ServeyController controller = Get.put(ServeyController());

  final List<Map<String, String>> skills = [
    {
      "title": "Beginner",
      "subtitle": "You're starting from scratch.",
      "icon": "assets/icons/begenar.svg",
    },
    {
      "title": "Intermediate",
      "subtitle": "You can hold simple conversations and understand everyday phrases..",
      "icon": "assets/icons/internediet.svg",
    },
    {
      "title": "Advanced",
      "subtitle": "You're comfortable understanding, speaking, reading, and writing about most topics..",
      "icon": "assets/icons/advance.svg",
    },
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
            /// Title Row
            Row(
              children: [
                CircleAvatar(
                  radius: 40.r,
                  backgroundImage: AssetImage(AppImages.putul),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    "How are your language skills so far?",
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

            /// Skills List
            Obx(() => Column(
              children: List.generate(skills.length, (index) {
                final skill = skills[index];
                final isSelected = controller.selectedSkill.value == index;

                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: GestureDetector(
                    onTap: () => controller.selectSkill(index),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 14.h),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.btnBG
                              : (isDark
                              ? Colors.grey.shade700
                              : Colors.grey.shade300),
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            skill["icon"]!,
                            width: 35.w,
                            height: 30.h,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  skill["title"]!,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color:
                                    isDark ? Colors.white : Colors.black,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  skill["subtitle"]!,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color:
                                    isDark ? Colors.white : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
            )),

            Spacer(),
            CustomButton(
              text: "Continue",
              onTap: () {
                if (controller.selectedSkill.value != -1) {
                  Get.to(() => SeerveyImproveSkill());
                } else {
                  Get.snackbar("Select skill", "Please select your skill level");
                }
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
}
