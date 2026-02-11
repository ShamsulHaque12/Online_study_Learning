
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_icons.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/features/search_friend/controller/search_friend_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class SearchFriendView extends StatelessWidget {
  SearchFriendView({super.key});

  final SearchFriendController controller = Get.put(SearchFriendController());

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final langController = Get.find<LanguageController>();
    final String friendId = Get.arguments ?? "";
    debugPrint("✅ Received Friend ID: $friendId");

    return Obx(() {
      final isDark = themeController.isDark.value;

      if (controller.isLoading.value) {
        return Scaffold(body: Center(child: SpinKitCircle(color: AppDarkColors.primaryColor, size: 50.w)));
      }

      final data = controller.friendProfile.value?.data;
      final user = data?.user;
      final weekly = data?.weeklyProgress ?? [];

      if (user == null) {
        return Scaffold(
          body: Center(
            child: Text(
              "No data found",
              style: GoogleFonts.inter(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ),
        );
      }

      return Scaffold(
        backgroundColor: isDark
            ? AppDarkColors.backgroundColor
            : AppLightColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: isDark ? Colors.white : Colors.black,
            ),
            onPressed: Get.back,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              /// 👤 Profile Image
              Stack(
                alignment: Alignment.topRight,
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundImage: NetworkImage(
                      user.image ??
                          "https://ui-avatars.com/api/?name=${user.fullName}",
                    ),
                  ),
                  if (user.isPremium == true)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 5.h,
                      ),
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
                ],
              ),

              const SizedBox(height: 12),

              /// 👤 Name
              Text(
                user.fullName ?? "",
                style: GoogleFonts.inter(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.orange,
                ),
              ),

              SizedBox(height: 4.h),

              /// Username & Joined
              Center(
                child: Text(
                  "@${user.userName} • Joined ${user.joinedAt}",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    color: Colors.teal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              /// Follow Button
              SizedBox(
                width: 180.w,
                height: 44.h,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () {
                    controller.followUser().then((success) {
                      if (success) {
                        user.isFollowing = true;
                        controller.friendProfile.refresh();
                      }
                    });
                  },
                  icon: const Icon(Icons.person_add),
                  label: Text(
                    user.isFollowing == true ? "Following" : "Follow",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              /// Weekly Progress
              Text(
                langController.selectedLanguage["Weekly progress"] ??
                    "Weekly progress",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: AppDarkColors.primaryColor,
                ),
              ),

              const SizedBox(height: 12),

              /// Chart (safe)
              Container(
                height: 200.h,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange, width: 2.w),
                ),
                child: weekly.isEmpty
                    ? Center(
                        child: Text(
                          "No progress data",
                          style: GoogleFonts.inter(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      )
                    : LineChart(
                        LineChartData(
                          gridData: FlGridData(show: false),
                          titlesData: FlTitlesData(
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: List.generate(
                                weekly.length,
                                (i) => FlSpot(
                                  i.toDouble(),
                                  (weekly[i].xp ?? 0).toDouble(),
                                ),
                              ),
                              isCurved: true,
                              color: Colors.orange,
                              barWidth: 3,
                              dotData: FlDotData(show: true),
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
