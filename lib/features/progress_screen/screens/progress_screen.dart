
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_images.dart';
import 'package:online_study/features/achivement/screens/achivement_screen.dart';
import 'package:online_study/features/home/controller/lesson_controller.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/features/leader_board/screens/leader_board_screen.dart';
import 'package:online_study/features/mastery/screens/mastery_screen.dart';
import 'package:online_study/features/point_table/screens/point_table_screen.dart';
import 'package:online_study/features/progress_screen/controller/progress_controller.dart';
import 'package:online_study/features/progress_screen/widgets/tab_status_item.dart';
import 'package:online_study/features/streck/screens/streck_screen.dart';
import 'package:online_study/global/widgets/custom_appbar.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class ProgressScreen extends StatelessWidget {
  ProgressScreen({super.key});
  final ProgressController controller = Get.put(ProgressController());
  final LessonController lessonController = Get.put(LessonController());
  final langController = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.isDark.value;

    return Scaffold(
      backgroundColor: isDark
          ? AppDarkColors.backgroundColor
          : AppLightColors.backgroundColor,
      appBar: CustomAppBar(
        fireCount: lessonController.user.value?.streak ?? 0,
        notoCount: lessonController.user.value?.totalPoint ?? 0,
      ),
      body: Column(
        children: [
          // USER CARD
          Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Image.asset(AppImages.pakhi2, height: 75.h, width: 75.w),
                SizedBox(width: 12.w),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppDarkColors.primaryColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(18.r),
                        bottomLeft: Radius.circular(18.r),
                        bottomRight: Radius.circular(18.r),
                      ),
                      border: Border(
                        bottom: BorderSide(color: Colors.black26, width: 6.w),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          langController.selectedLanguage["Great job,"] ?? "Great job,",
                          style: GoogleFonts.inter(
                            fontSize: 18.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          langController.selectedLanguage["Keep up your learning Progress!"] ?? "Keep up your learning Progress!",
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // TAB BAR
          Obx(
            () => Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => controller.changeTab(0),
                        child: TabStatusItem(
                          icon: "assets/images/achivenebt1.png",
                          value: "0",
                          label: "Achievement",
                          isSelected: controller.selectedTab.value == 0,
                        ),
                      ),
                      const TabDivider(),
                      GestureDetector(
                        onTap: () => controller.changeTab(1),
                        child: TabStatusItem(
                          icon: "assets/images/mastery1.png",
                          value: "0",
                          label: "Mastery",
                          isSelected: controller.selectedTab.value == 1,
                        ),
                      ),
                      const TabDivider(),
                      GestureDetector(
                        onTap: () => controller.changeTab(2),
                        child: TabStatusItem(
                          icon: "assets/images/leaderboard.png",
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
                          icon: "assets/images/fire.png",
                          value: "0",
                          label: "Streak",
                          isSelected: controller.selectedTab.value == 3,
                        ),
                      ),
                      const TabDivider(),
                      GestureDetector(
                        onTap: () => controller.changeTab(4),
                        child: TabStatusItem(
                          icon: "assets/images/egg1.png",
                          value: "0",
                          label: "Point",
                          isSelected: controller.selectedTab.value == 4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // TAB CONTENT
          Expanded(
            child: Obx(() {
              switch (controller.selectedTab.value) {
                case 0:
                  return AchivementScreen();
                case 1:
                  return MasteryScreen();
                case 2:
                  return LeaderBoardScreen();
                case 3:
                  return StreckScreen();
                case 4:
                  return PointTableScreen();
                default:
                  return AchivementScreen();
              }
            }),
          ),
        ],
      ),
    );
  }
}
