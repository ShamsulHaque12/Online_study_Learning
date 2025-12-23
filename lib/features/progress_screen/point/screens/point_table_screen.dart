
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../core/app_colours.dart';
import '../../../../core/app_icons.dart';
import '../../custom_widgets_card/stats_card.dart';

class PointTableScreen extends StatelessWidget {
  const PointTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                AppIcons.goal,
                height: 20.h,
                width: 20.w,
                color: AppColors.text2,
              ),
              SizedBox(width: 10.w),
              Text(
                "My Daily Goal",
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.text2,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          // LineChart container
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[850] : Colors.grey[50],
              border: Border.all(
                color: AppColors.text2.withOpacity(0.5),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: SizedBox(
              height: 170.h,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Weekly Points",
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.grey[300] : Colors.grey[700],
                        ),
                      ),
                      Text(
                        "133 P",
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.grey[300] : Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Expanded(
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          horizontalInterval: 10,
                          getDrawingHorizontalLine: (value) {
                            return FlLine(
                              color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                              strokeWidth: 1,
                            );
                          },
                        ),
                        titlesData: FlTitlesData(
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30.w,
                            ),
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
                                const days = ['T', 'W', 'T', 'F', 'S', 'S', 'M'];
                                if (value.toInt() >= 0 &&
                                    value.toInt() < days.length) {
                                  return Padding(
                                    padding: EdgeInsets.only(top: 8.h),
                                    child: Text(
                                      days[value.toInt()],
                                      style: GoogleFonts.inter(
                                        color: isDark
                                            ? Colors.grey[500]
                                            : Colors.grey[400],
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
                        maxX: 6,
                        minY: 0,
                        maxY: 30,
                        lineBarsData: [
                          LineChartBarData(
                            spots: const [
                              FlSpot(0, 6),
                              FlSpot(1, 4),
                              FlSpot(2, 13),
                              FlSpot(3, 10),
                              FlSpot(4, 12),
                              FlSpot(5, 26),
                              FlSpot(6, 16),
                            ],
                            isCurved: false,
                            color: AppColors.text2,
                            barWidth: 3,
                            isStrokeCapRound: true,
                            dotData: FlDotData(
                              show: true,
                              getDotPainter: (spot, percent, barData, index) {
                                return FlDotCirclePainter(
                                  radius: 5,
                                  color: AppColors.text2,
                                  strokeWidth: 0,
                                );
                              },
                            ),
                            belowBarData: BarAreaData(show: false),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 10.h),
          StatsCard(
            title: "Total",
            isDark: isDark,
            items: [
              IconTextPair(iconPath: AppIcons.time, text: "0"),
              IconTextPair(iconPath: AppIcons.egg, text: "0"),
            ],
          ),
          SizedBox(height: 10.h),
          StatsCard(
            title: "This Week",
            isDark: isDark,
            items: [
              IconTextPair(iconPath: AppIcons.time, text: "2m 6s"),
              IconTextPair(iconPath: AppIcons.egg, text: "0"),
            ],
          ),
          SizedBox(height: 10.h),
          StatsCard(
            title: "Oct 15,2025",
            isDark: isDark,
            items: [
              IconTextPair(iconPath: AppIcons.time, text: "+2m 6s"),
              IconTextPair(iconPath: AppIcons.egg, text: "+20"),
            ],
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
