
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/app_colours.dart';
import '../../../core/app_icons.dart';
import '../../../core/app_images.dart';
import '../controller/progress_controller.dart';
import '../achievment/screens/achievement_screen.dart';
import '../leaderboard/screens/leaderboard_screen.dart';
import '../mastery/screens/mastery_screen.dart';
import '../point/screens/point_table_screen.dart';
import '../streak/screens/streak_screen.dart';
import '../custom_widgets_card/tab_status_item.dart';

class ProgressScreenView extends StatelessWidget {
  const ProgressScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProgressController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// HEADER
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Image.asset(AppImages.pakhi1, height: 70.h, width: 65.w),
                  SizedBox(width: 10.w),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.btnBG,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12.r),
                        bottomRight: Radius.circular(12.r),
                        bottomLeft: Radius.circular(12.r),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Great job, Name!",
                          style: GoogleFonts.baloo2(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.btnwhite,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          "Keep up your learning Progress!",
                          style: GoogleFonts.nunito(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.btnwhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.h),

            /// TAB BAR
            Obx(() => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => controller.changeTab(0),
                      child: TabStatusItem(
                        icon: AppIcons.achivment,
                        value: "0",
                        label: "Achievement",
                        isSelected: controller.selectedTab.value == 0,
                      ),
                    ),

                    const TabDivider(),

                    GestureDetector(
                      onTap: () => controller.changeTab(1),
                      child: TabStatusItem(
                        icon: AppIcons.mestery,
                        value: "0",
                        label: "Mastery",
                        isSelected: controller.selectedTab.value == 1,
                      ),
                    ),

                    const TabDivider(),

                    GestureDetector(
                      onTap: () => controller.changeTab(2),
                      child: TabStatusItem(
                        icon: AppIcons.leader,
                        value: "0",
                        label: "Leaderboard",
                        isSelected: controller.selectedTab.value == 2,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 5.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => controller.changeTab(3),
                      child: TabStatusItem(
                        icon: AppIcons.agun,
                        value: "0",
                        label: "Streak",
                        isSelected: controller.selectedTab.value == 3,
                      ),
                    ),

                    const TabDivider(),

                    GestureDetector(
                      onTap: () => controller.changeTab(4),
                      child: TabStatusItem(
                        icon: AppIcons.egg,
                        value: "0",
                        label: "Point",
                        isSelected: controller.selectedTab.value == 4,
                      ),
                    ),
                  ],
                ),
              ],
            )),

            SizedBox(height: 10.h),

            /// TAB CONTENT
            Expanded(
              child: Obx(() {
                switch (controller.selectedTab.value) {
                  case 0:
                    return AchievementScreen();
                  case 1:
                    return MasteryScreen();
                  case 2:
                    return LeaderboardScreen();
                  case 3:
                    return StreakScreen();
                  case 4:
                    return PointTableScreen();
                  default:
                    return StreakScreen();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
