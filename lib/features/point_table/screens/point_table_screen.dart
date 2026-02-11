
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_icons.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/features/point_table/controller/point_table_controller.dart';
import 'package:online_study/features/point_table/widgets/stats_card.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class PointTableScreen extends StatelessWidget {
  PointTableScreen({super.key});
  final PointTableController controller = Get.put(PointTableController());
  final langController = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(() {
      final isDark = themeController.isDark.value;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(AppIcons.goal, height: 20.h, width: 20.w),
              SizedBox(width: 10.w),
              Text(
                langController.selectedLanguage["My Daily Goal"] ?? "My Daily Goal",
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppDarkColors.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          // LineChart container
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
                height: 170.h,
                child: Column(
                  children: [
                    /// 🔥 Header (always visible)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          langController.selectedLanguage["Weekly Points"] ?? "Weekly Points",
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? AppDarkColors.primaryTextColor
                                : AppLightColors.primaryTextColor,
                          ),
                        ),
                        Text(
                          "${controller.totalWeeklyPoints} P",
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

                    /// 🔥 Line Chart (never empty)
                    Expanded(
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: false,
                            horizontalInterval: 10,
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                color: isDark
                                    ? Colors.grey[700]!
                                    : Colors.grey[300]!,
                                strokeWidth: 1,
                              );
                            },
                          ),
                          titlesData: FlTitlesData(
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30.w,
                                interval: 10,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toInt().toString(),
                                    style: GoogleFonts.inter(
                                      color: isDark
                                          ? Colors.grey[500]
                                          : Colors.grey[400],
                                      fontSize: 12.sp,
                                    ),
                                  );
                                },
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30.h,
                                getTitlesWidget: (value, meta) {
                                  const days = [
                                    'M',
                                    'T',
                                    'W',
                                    'T',
                                    'F',
                                    'S',
                                    'S',
                                  ];
                                  if (value.toInt() < days.length) {
                                    return Padding(
                                      padding: EdgeInsets.only(top: 8.h),
                                      child: Text(
                                        days[value.toInt()],
                                        style: GoogleFonts.inter(
                                          color: isDark
                                              ? AppDarkColors.primaryTextColor
                                              : AppLightColors.primaryTextColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    );
                                  }
                                  return const SizedBox();
                                },
                              ),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          minX: 0,
                          maxX: (controller.safeDailyPoints.length - 1)
                              .toDouble(),
                          minY: 0,
                          maxY: 30,
                          lineBarsData: [
                            LineChartBarData(
                              spots: controller.weeklyPointSpots,
                              isCurved: false,
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
          Obx(() {
            return Column(
              children: [
                StatsCard(
                  title: langController.selectedLanguage["Total"] ?? "Total",
                  isDark: isDark,
                  items: [
                    IconTextPair(
                      iconPath: AppIcons.time,
                      text: controller.formatTime(controller.totalTimeSec),
                    ),
                    IconTextPair(
                      iconPath: AppIcons.egg,
                      text: controller.totalPoints.toString(),
                    ),
                  ],
                ),

                SizedBox(height: 10.h),
                StatsCard(
                  title: langController.selectedLanguage["This Week"] ?? "This Week",
                  isDark: isDark,
                  items: [
                    IconTextPair(
                      iconPath: AppIcons.time,
                      text: controller.formatTime(controller.thisWeekTimeSec),
                    ),
                    IconTextPair(
                      iconPath: AppIcons.egg,
                      text: controller.thisWeekPoints.toString(),
                    ),
                  ],
                ),
              ],
            );
          }),
          SizedBox(height: 10.h),
          Obx(() {
            return Column(
              children: List.generate(controller.last7History.length, (index) {
                final item = controller.last7History[index];

                return Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: StatsCard(
                    title: controller.formatHistoryDate(item.completedAt),
                    isDark: isDark,
                    items: [
                      IconTextPair(
                        iconPath: AppIcons.time,
                        text: controller.formatTime(
                          item.metadata?.timeTakenSec ?? 0,
                        ),
                      ),
                      IconTextPair(
                        iconPath: AppIcons.egg,
                        text: "+${item.metadata?.totalPoints ?? 0}",
                      ),
                    ],
                  ),
                );
              }),
            );
          }),
          SizedBox(height: 20.h),
        ],
      ),
    );
    });
  }
}
