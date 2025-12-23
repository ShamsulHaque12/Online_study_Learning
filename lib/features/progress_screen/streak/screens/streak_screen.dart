
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/app_colours.dart';
import '../../../../core/app_icons.dart';
import '../controller/streakController.dart';

class StreakScreen extends StatelessWidget {
  StreakScreen({super.key});

  final Streakcontroller controller = Get.put(Streakcontroller());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(
              () => TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: controller.focusedDay.value,
                selectedDayPredicate: (day) {
                  return controller.selectedDay.value != null &&
                      controller.selectedDay.value!.isAtSameMomentAs(day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  controller.selectDay(selectedDay);
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    color: AppColors.grammer,
                    fontWeight: FontWeight.w800,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Streak Target",
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.bgLight : AppColors.lightText,
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                SvgPicture.asset(AppIcons.calendar, height: 20.h, width: 20.w),
                SizedBox(width: 10.w),

                // Make progress bar expand to fill available space
                Expanded(
                  child: Obx(() {
                    double value = controller.progress.value;
                    int orange = (value * 100).toInt();
                    int gray = 100 - orange;

                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: SizedBox(
                        height: 10.h,
                        child: Row(
                          children: [
                            Expanded(
                              flex: orange,
                              child: Container(color: Colors.orange),
                            ),

                            Expanded(
                              flex: gray,
                              child: Container(color: Colors.grey[300]),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),

                SizedBox(width: 10.w),
                SvgPicture.asset(AppIcons.calendar, height: 20.h, width: 20.w),
              ],
            ),
            SizedBox(height: 10.h),
            Text(
              "4/7days",
              style: GoogleFonts.nunito(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.bgLight : AppColors.gray,
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                SvgPicture.asset(AppIcons.agun, height: 25.h, width: 25.w),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Day Streak",
                        style: GoogleFonts.nunito(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? AppColors.bgLight
                              : AppColors.lightText,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "Complete one lesson to light today’s frame",
                        style: GoogleFonts.nunito(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: isDark ? AppColors.bgLight : AppColors.gray,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                SvgPicture.asset(AppIcons.pani, height: 25.h, width: 25.w),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Day Shields",
                            style: GoogleFonts.nunito(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? AppColors.bgLight
                                  : AppColors.lightText,
                            ),
                          ),
                          Text(
                            "x 1000",
                            style: GoogleFonts.nunito(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.text2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "Streak shields will automatically protect your streak for up to 2 missed days. You can earn shields by learning",
                        style: GoogleFonts.nunito(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: isDark ? AppColors.bgLight : AppColors.gray,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
