
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_icons.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/features/streck/controller/streck_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class StreckScreen extends StatelessWidget {
  StreckScreen({super.key});
  final StreckController controller = Get.put(StreckController());
  final langController = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(() {
      final isDark = themeController.isDark.value;

    return SingleChildScrollView(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          // 🔹 Calendar
          Obx(
            () => TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2035, 12, 31),
              focusedDay: controller.focusedDay.value,
              selectedDayPredicate: (day) =>
                  isSameDay(controller.selectedDay.value, day),
              calendarFormat: CalendarFormat.month,
              onDaySelected: controller.onDaySelected,
              onPageChanged: controller.onPageChanged,
              availableGestures: AvailableGestures.all,
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                titleTextStyle: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: AppDarkColors.textColors2,
                ),
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: isDark
                      ? AppDarkColors.btnColor
                      : AppLightColors.btnColor,
                ),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: isDark
                      ? AppDarkColors.btnColor
                      : AppLightColors.btnColor,
                ),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: GoogleFonts.inter(
                  color: isDark
                      ? AppDarkColors.btnColor
                      : AppLightColors.btnColor,
                  fontSize: 12.sp,
                  letterSpacing: 1,
                ),
                weekendStyle: GoogleFonts.inter(
                  color: isDark
                      ? AppDarkColors.btnColor
                      : AppLightColors.btnColor,
                  fontSize: 12.sp,
                ),
              ),
              calendarStyle: const CalendarStyle(outsideDaysVisible: false),
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  // 🔹 Fire days from API
                  if (controller.isFire(day)) {
                    return _svgDate(day.day, AppIcons.fireIcon);
                  }

                  // 🔹 Current day as Water
                  if (controller.isWater(day)) {
                    return _svgDate(day.day, AppIcons.water);
                  }

                  // 🔹 Normal day
                  return Center(
                    child: Text(
                      '${day.day}',
                      style: GoogleFonts.inter(
                        color: isDark
                            ? AppDarkColors.btnColor
                            : AppLightColors.btnColor,
                        fontSize: 14.sp,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // 🔹 Inside Column after TableCalendar
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Obx(() {
              double value = controller.progress.value;
              int orange = (value * 100).toInt();
              int gray = 100 - orange;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    langController.selectedLanguage["Streak Target"] ?? "Streak Target",
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppDarkColors.primaryTextColor
                          : AppLightColors.primaryTextColor,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppIcons.calender,
                        height: 20.h,
                        width: 20.w,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: ClipRRect(
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
                        ),
                      ),
                      SizedBox(width: 10.w),
                      SvgPicture.asset(
                        AppIcons.calender,
                        height: 20.h,
                        width: 20.w,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "${controller.currentStreak}/${controller.target} days",
                    style: GoogleFonts.nunito(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppDarkColors.primaryTextColor
                          : AppLightColors.primaryTextColor,
                    ),
                  ),
                ],
              );
            }),
          ),

          SizedBox(height: 20.h),
          Row(
            children: [
              SvgPicture.asset(AppIcons.agun, height: 25.h, width: 25.w),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      langController.selectedLanguage["Day Streak"] ?? "Day Streak",
                      style: GoogleFonts.nunito(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppDarkColors.primaryTextColor
                            : AppLightColors.primaryTextColor,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      langController.selectedLanguage["Complete one lesson to light today’s frame"] ?? "Complete one lesson to light today’s frame",
                      style: GoogleFonts.nunito(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: isDark
                            ? AppDarkColors.primaryTextColor
                            : AppLightColors.primaryTextColor,
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
              SvgPicture.asset(AppIcons.water, height: 25.h, width: 25.w),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          langController.selectedLanguage["Day Shields"] ?? "Day Shields",
                          style: GoogleFonts.nunito(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? AppDarkColors.primaryTextColor
                                : AppLightColors.primaryTextColor,
                          ),
                        ),
                        Text(
                          "x 1000",
                          style: GoogleFonts.nunito(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppDarkColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                     langController.selectedLanguage["Streak shields will automatically protect your streak for up to 2 missed days. You can earn shields by learning"] ?? "Streak shields will automatically protect your streak for up to 2 missed days. You can earn shields by learning"  ,
                      style: GoogleFonts.nunito(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: isDark
                            ? AppDarkColors.primaryTextColor
                            : AppLightColors.primaryTextColor,
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
    );
    });
  }


  Widget _svgDate(int day, String asset) {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.isDark.value;
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(asset, height: 34.h, width: 34.w),
        Text(
          '$day',
          style: GoogleFonts.inter(
            color: isDark ? AppDarkColors.btnColor : AppLightColors.btnColor,
            fontWeight: FontWeight.bold,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}
