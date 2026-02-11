
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_icons.dart';
import 'package:online_study/features/setting_screen/controller/daily_goal_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class DailyGoalsScreen extends StatelessWidget {
  DailyGoalsScreen({super.key});
  final DailyGoalController controller = Get.put(DailyGoalController());

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
        scrolledUnderElevation: 0,
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
          "Daily Goals",
          style: GoogleFonts.inter(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Goal",
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: AppDarkColors.primaryColor,
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: isDark ? Color(0xFFFFFFFF) : AppDarkColors.borderLine,
                  width: 2.w,
                ),
              ),
              child: Column(
                children: List.generate(controller.routines.length, (index) {
                  final item = controller.routines[index];

                  return Container(
                    margin: EdgeInsets.only(bottom: 12),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppIcons.time,
                          height: 35.h,
                          width: 35.w,
                          color: isDark
                              ? Color(0xFFFFFFFF)
                              : AppDarkColors.borderLine,
                        ),

                        SizedBox(width: 10.w),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: isDark
                                      ? Color(0xFFFFFFFF)
                                      : Colors.black,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                item.duration,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: isDark
                                      ? Color(0xFFFFFFFF)
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Obx(
                          () => Transform.scale(
                            scale: 1.4,
                            child: Checkbox(
                              value: controller.selected[index],
                              onChanged: (val) => controller.toggleCheck(index),
                              activeColor: AppDarkColors.primaryColor,
                              shape: const CircleBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Reminders",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: AppDarkColors.primaryColor,
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: isDark ? Color(0xFFFFFFFF) : Colors.black,
                  width: 2.w,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Row (Reminder title + Switch)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppIcons.time,
                            height: 20.h,
                            width: 20.w,
                            color: isDark
                                ? Color(0xFFFFFFFF)
                                : AppDarkColors.borderLine,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Get reminders",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: isDark ? Color(0xFFFFFFFF) : Colors.black,
                            ),
                          ),
                        ],
                      ),

                      Obx(
                        () => Switch(
                          value: controller.isReminderOn.value,
                          activeThumbColor: AppDarkColors.textColors2,
                          activeTrackColor: AppDarkColors.primaryColor,
                          onChanged: (val) =>
                              controller.isReminderOn.value = val,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  // TIME PICKER (visible only when switch is ON)
                  Obx(
                    () => controller.isReminderOn.value
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Hour Picker
                              SizedBox(
                                height: 120.h,
                                width: 60.w,
                                child: CupertinoPicker(
                                  itemExtent: 32,
                                  looping: true,
                                  onSelectedItemChanged: (i) {
                                    controller.selectedHour.value =
                                        controller.hours[i];
                                  },
                                  children: controller.hours
                                      .map(
                                        (e) => Center(
                                          child: Text(
                                            e.toString(),
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),

                              // Minute Picker
                              SizedBox(
                                height: 120.h,
                                width: 60.w,
                                child: CupertinoPicker(
                                  itemExtent: 32,
                                  looping: true,
                                  onSelectedItemChanged: (i) {
                                    controller.selectedMinute.value =
                                        controller.minutes[i];
                                  },
                                  children: controller.minutes
                                      .map(
                                        (e) => Center(
                                          child: Text(
                                            e.toString().padLeft(2, "0"),
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),

                              // AM / PM Picker
                              SizedBox(
                                height: 120.h,
                                width: 60.w,
                                child: CupertinoPicker(
                                  itemExtent: 32,
                                  looping: true,
                                  onSelectedItemChanged: (i) {
                                    controller.selectedPeriod.value =
                                        controller.periods[i];
                                  },
                                  children: controller.periods
                                      .map(
                                        (e) => Center(
                                          child: Text(
                                            e,
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ],
                          )
                        : SizedBox.shrink(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
    });
  }
}
