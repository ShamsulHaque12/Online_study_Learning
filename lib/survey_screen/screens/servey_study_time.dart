import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:online_study/survey_screen/screens/servey_why_learning.dart';
import '../../component/custom_widgets/custom_button.dart';
import '../../core/app_colours.dart';
import '../../core/app_images.dart';
import '../controller/servey_controller.dart';

class ServeyStudyTime extends StatelessWidget {
  ServeyStudyTime({super.key});
  final ServeyController controller = Get.put(ServeyController());
  final List<Map<String, String>> times = [
    {
      "title": "5min",
      "icon": "assets/icons/time.svg",
    },
    {
      "title": "10min",
      "icon": "assets/icons/time.svg",
    },
    {
      "title": "15min",
      "icon": "assets/icons/time.svg",
    },
    {
      "title": "20min",
      "icon": "assets/icons/time.svg",
    },
    {
      "title": "25min",
      "icon": "assets/icons/time.svg",
    },
    {
      "title": "30min",
      "icon": "assets/icons/time.svg",
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
          onTap: () => Get.back(),
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
                    "How long can you study, ${controller.nameController.text} ?",
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
              children: List.generate(times.length, (index) {
                final skill = times[index];
                final isSelected = controller.selectedTime.value == index;

                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: GestureDetector(
                    onTap: () => controller.selectTimes(index),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.btnBG
                              : (isDark
                              ? Colors.grey.shade700
                              : Colors.grey.shade300),
                          width: 2.w,
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
               Get.to(()=>ServeyWhyLearning());
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
