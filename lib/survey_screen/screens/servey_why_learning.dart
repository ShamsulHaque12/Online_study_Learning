import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:online_study/survey_screen/screens/servey_remainder.dart';
import '../../component/custom_widgets/custom_button.dart';
import '../../core/app_colours.dart';
import '../../core/app_images.dart';
import '../controller/servey_controller.dart';

class ServeyWhyLearning extends StatelessWidget {
  ServeyWhyLearning({super.key});
  final ServeyController controller = Get.put(ServeyController());

  final List<Map<String, String>> works = [
    {
      "title": "For travel",
      "subtitle": "I want to communicate while traveling.",
      "icon": "assets/icons/travel.svg",
    },
    {
      "title": "For work",
      "subtitle": "I need English for my job or career.",
      "icon": "assets/icons/work.svg",
    },
    {
      "title": "For study and exam",
      "subtitle": "I want to improve my academic English.",
      "icon": "assets/icons/exam.svg",
    },
    {
      "title": "Just for fun",
      "subtitle": "I enjoy learning new languages.",
      "icon": "assets/icons/fun.svg",
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
                    "Why are you learning English?",
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
              children: List.generate(works.length, (index) {
                final skill = works[index];
                final isSelected = controller.selectedWork.value == index;

                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: GestureDetector(
                    onTap: () => controller.selectWork(index),
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
                  Get.to(() => ServeyRemainder());
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
