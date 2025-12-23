
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../component/custom_widgets/custom_button.dart';
import '../../../core/app_colours.dart';
import '../../../core/app_icons.dart';
import '../../../core/app_images.dart';
import '../../setting_screen/screens/setting_screen_view.dart';
import '../controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.btnBG,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppIcons.taj,
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

                  /// Settings Button
                  GestureDetector(
                    onTap: () => Get.to(() => SettingScreenView()),
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
              Center(
                child: CircleAvatar(
                  radius: 70.r,
                  backgroundImage: AssetImage(AppImages.pakhi1),
                ),
              ),
              SizedBox(height: 10.h),
              Center(
                child: Text(
                  "Name",
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.btnBG,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "@shortName",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grammer,
                    ),
                  ),
                  SizedBox(width: 20.w),
                  SvgPicture.asset(AppIcons.circel),
                  SizedBox(width: 5.w),
                  Text(
                    "Joined October2025",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grammer,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Center(
                child: CustomButton(
                  width: MediaQuery.sizeOf(context).width * 0.50,
                  text: "Add Friend",
                  onTap: () {},
                  prefixIcon: Icon(Icons.person_add_alt, color: Colors.white),
                  backgroundColor: AppColors.btnTextBule,
                  borderColor: Colors.transparent,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "Weekly progress",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.btnBG,
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: AppColors.btnBG, width: 2.w),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 10.h,
                              width: 10.w,
                              decoration: BoxDecoration(
                                color: AppColors.btnBG,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              "My",
                              style: GoogleFonts.inter(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.btnBG,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "1393 XP",
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: isDark ? Colors.grey[400] : Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    SizedBox(
                      height: 150.h,
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: false,
                            horizontalInterval: 400,
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
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
                                reservedSize: 40.w,
                                interval: 400,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toInt().toString(),
                                    style: GoogleFonts.inter(
                                      color: isDark ? Colors.grey[500] : Colors.grey[400],
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
                                  if (value.toInt() >= 0 && value.toInt() < days.length) {
                                    return Padding(
                                      padding: EdgeInsets.only(top: 8.h),
                                      child: Text(
                                        days[value.toInt()],
                                        style: GoogleFonts.inter(
                                          color: isDark ? Colors.grey[500] : Colors.grey[400],
                                          fontSize: 13.sp,
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
                          maxY: 1200,
                          lineBarsData: [
                            LineChartBarData(
                              spots: const [
                                FlSpot(0, 200),  // T
                                FlSpot(1, 150),  // W
                                FlSpot(2, 500),  // T
                                FlSpot(3, 400),  // F
                                FlSpot(4, 500),  // S
                                FlSpot(5, 950),  // S
                                FlSpot(6, 600),  // M
                              ],
                              isCurved: false,
                              color: AppColors.btnBG,
                              barWidth: 2.5,
                              isStrokeCapRound: true,
                              dotData: FlDotData(
                                show: true,
                                getDotPainter: (spot, percent, barData, index) {
                                  return FlDotCirclePainter(
                                    radius: 4.5,
                                    color: AppColors.btnBG,
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

              SizedBox(height: 10.h),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StreakCard(
                    title: "2 Days",
                    subtitle: "Streak",
                    icon: AppIcons.agun,
                    bgColor: AppColors.box,
                    textColor: AppColors.text2,
                  ),
                  SizedBox(height: 10.h),
                  StreakCard(
                    title: "2 words",
                    subtitle: "Vocabulary",
                    icon: AppIcons.word,
                    bgColor: AppColors.box,
                    textColor: AppColors.text2,
                  ),
                  SizedBox(height: 10.h),
                  StreakCard(
                    title: "2 / 20",
                    subtitle: "Chapter",
                    icon: AppIcons.chapter,
                    bgColor: AppColors.box,
                    textColor: AppColors.text2,
                  ),
                  SizedBox(height: 10.h),
                  StreakCard(
                    title: "212 EXP",
                    subtitle: "Bronze Class",
                    icon: AppIcons.bronze,
                    bgColor: AppColors.box,
                    textColor: AppColors.text2,
                  ),
                ],
              ),
              SizedBox(height: 10.h),


            ],
          ),
        ),
      ),
    );
  }
}
class StreakCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;
  final Color bgColor;
  final Color textColor;

  const StreakCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center, // Column এ সেন্টারে থাকবে
      child: Container(
        width: 250.w, // FIXED WIDTH so serial wise nicely দেখা যায়
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 60.h,
              width: 70.w,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: SvgPicture.asset(icon),
            ),

            SizedBox(width: 10.w),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: textColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
