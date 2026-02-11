
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_icons.dart';
import 'package:online_study/constraints/app_images.dart';
import 'package:online_study/features/home/controller/lesson_controller.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/features/profile_screen/controller/profile_controller.dart';
import 'package:online_study/route/app_routes.dart';
import 'package:online_study/services/api_endpoints.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final LessonController lessonController = Get.find<LessonController>();
  final ProfileController controller = Get.put(ProfileController());
  final langController = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      final isDark = themeController.isDark.value;

      return Scaffold(
        backgroundColor:
            isDark ? AppDarkColors.backgroundColor : AppLightColors.backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row (Premium + Settings)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Premium Badge
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        color: AppDarkColors.primaryColor,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppIcons.crownIcon,
                            height: 22.h,
                            width: 22.w,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            "Premium",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    // Settings Button
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.settingScreen),
                      child: SvgPicture.asset(
                        AppIcons.setting,
                        height: 26.h,
                        width: 26.w,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                // User Avatar
                Obx(() {
                  final user = lessonController.user.value;
                  final imageUrl = resolveUserImage(user?.image);

                  return Center(
                    child: CircleAvatar(
                      radius: 70.r,
                      backgroundColor: Colors.transparent,
                      backgroundImage: imageUrl != null
                          ? NetworkImage(imageUrl)
                          : AssetImage(AppImages.avator) as ImageProvider,
                    ),
                  );
                }),

                SizedBox(height: 10.h),

                // User Info
                Obx(() {
                  final user = lessonController.user.value;
                  String joinedText = "Joined";

                  if (user?.createdAt != null) {
                    final date = DateTime.tryParse(user!.createdAt!);
                    if (date != null) {
                      joinedText = "Joined ${_monthName(date.month)} ${date.year}";
                    }
                  }

                  return Column(
                    children: [
                      Center(
                        child: Text(
                          user?.fullName ?? "Full Name",
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w700,
                            color: AppDarkColors.primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "@${user?.userName ?? "username"}",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: AppDarkColors.textColors2,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          SvgPicture.asset(AppIcons.circel),
                          SizedBox(width: 5.w),
                          Text(
                            joinedText,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: AppDarkColors.textColors2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),

                SizedBox(height: 20.h),

                Text(
                  langController.selectedLanguage["Weekly progress"] ?? "Weekly progress",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: AppDarkColors.primaryColor,
                  ),
                ),

                SizedBox(height: 10.h),

                // Weekly Progress Chart
                Obx(() {
                  return Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[850] : Colors.grey[50],
                      border: Border.all(
                        color: AppDarkColors.primaryColor.withOpacity(0.5),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: SizedBox(
                      height: 180.h,
                      child: Column(
                        children: [
                          // Header with total points
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                langController.selectedLanguage["My Points"] ?? "My Points",
                                style: GoogleFonts.inter(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: isDark
                                      ? AppDarkColors.primaryTextColor
                                      : AppLightColors.primaryTextColor,
                                ),
                              ),
                              Text(
                                "${controller.totalWeeklyPoints} XP",
                                style: GoogleFonts.inter(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: isDark
                                      ? AppDarkColors.primaryTextColor
                                      : AppLightColors.primaryTextColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.h),

                          // Line Chart
                          Expanded(
                            child: LineChart(
                              LineChartData(
                                gridData: FlGridData(
                                  show: true,
                                  drawVerticalLine: false,
                                  horizontalInterval: 5,
                                  getDrawingHorizontalLine: (value) => FlLine(
                                    color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                                    strokeWidth: 1,
                                  ),
                                ),
                                titlesData: FlTitlesData(
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 30.h,
                                      getTitlesWidget: (value, meta) {
                                        return Padding(
                                          padding: EdgeInsets.only(top: 8.h),
                                          child: Text(
                                            controller.chartLabel(value.toInt()),
                                            style: GoogleFonts.inter(
                                              color: isDark
                                                  ? AppDarkColors.primaryTextColor
                                                  : AppLightColors.primaryTextColor,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      interval: 5,
                                      reservedSize: 30.w,
                                      getTitlesWidget: (value, meta) => Text(
                                        value.toInt().toString(),
                                        style: GoogleFonts.inter(
                                          color: isDark ? Colors.grey[500] : Colors.grey[400],
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                  topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                ),
                                borderData: FlBorderData(show: false),
                                minX: 0,
                                maxX: (controller.safeDailyPoints.length - 1).toDouble(),
                                minY: 0,
                                maxY: controller.safeDailyPoints
                                        .map((e) => e.points)
                                        .fold(0, (a, b) => a > b ? a : b) +
                                    5,
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: controller.weeklyPointSpots,
                                    isCurved: true,
                                    color: AppDarkColors.primaryColor,
                                    barWidth: 3,
                                    dotData: FlDotData(show: true),
                                    belowBarData: BarAreaData(show: false),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),

                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      );
    });
  }

  String _monthName(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return months[month - 1];
  }

  String? resolveUserImage(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) return null;
    if (imagePath.contains('undefined')) return null;
    if (imagePath.startsWith('http')) return imagePath;
    return "${ApiEndpoints.baseUrl}$imagePath";
  }
}
