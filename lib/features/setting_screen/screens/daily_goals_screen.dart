import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../core/app_colours.dart';
import '../../../core/app_icons.dart';
import '../controller/daily_goals_controller.dart';

class DailyGoalsScreen extends StatelessWidget {
  final DailyGoalsController controller = Get.put(DailyGoalsController());
  DailyGoalsScreen({super.key});

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
          "Daily Goals",
          style: TextStyle(
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
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.btnBG,
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: isDark ? AppColors.bgLight : AppColors.borderLine,
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
                              ? AppColors.bgLight
                              : AppColors.borderLine,
                        ),

                        SizedBox(width: 10.w),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: isDark
                                      ? AppColors.bgLight
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
                                      ? AppColors.bgLight
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Obx(
                          () => Checkbox(
                            value: controller.selected[index],
                            onChanged: (val) => controller.toggleCheck(index),
                            shape: CircleBorder(),
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
                color: AppColors.btnBG,
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: isDark ? AppColors.bgLight : Colors.black,
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
                                ? AppColors.bgLight
                                : AppColors.borderLine,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Get reminders",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: isDark ? AppColors.bgLight : Colors.black,
                            ),
                          ),
                        ],
                      ),

                      Obx(
                        () => Switch(
                          value: controller.isReminderOn.value,
                          activeColor: AppColors.grammer,
                          activeTrackColor: AppColors.btnBG,
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
  }
}
