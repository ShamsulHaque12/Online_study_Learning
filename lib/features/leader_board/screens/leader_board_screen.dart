// LeaderBoardScreen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_icons.dart';
import 'package:online_study/constraints/app_images.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/features/leader_board/controller/leader_board_controller.dart';
import 'package:online_study/features/leader_board/screens/friends_screen.dart';
import 'package:online_study/features/leader_board/screens/global_screen.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class LeaderBoardScreen extends StatelessWidget {
  LeaderBoardScreen({super.key});

  final LeaderBoardController controller = Get.put(LeaderBoardController());
  final langController = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final screenHeight = MediaQuery.of(context).size.height;

    return Obx(() {
    final isDark = themeController.isDark.value;
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
          child: Column(
            children: [
              /// Leaderboard Top 3
              Obx(() {
                if (controller.friends.isEmpty) {
                  return Center(
                    child: SpinKitCircle(color: AppDarkColors.primaryColor),
                  );
                }

                // Sort by points descending
                final sorted = List.of(controller.friends);
                sorted.sort(
                  (a, b) => (b.totalPoints ?? 0).compareTo(a.totalPoints ?? 0),
                );

                // Take top 3
                final top3 = sorted.take(3).toList();

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(top3.length, (index) {
                      final friend = top3[index];
                      // Customize height/color for positions
                      double height;
                      Color color;
                      bool crown = false;
                      switch (index) {
                        case 0:
                          height = 220.h;
                          color = const Color(0xFF00A7A7);
                          crown = true;
                          break;
                        case 1:
                          height = 180.h;
                          color = const Color(0xFF884F35);
                          break;
                        case 2:
                          height = 150.h;
                          color = const Color(0xFFDF6B38);
                          break;
                        default:
                          height = 150.h;
                          color = Colors.grey;
                      }

                      return _LeaderboardItem(
                        position: "${index + 1}",
                        name: friend.fullName ?? "—",
                        points: "${friend.totalPoints ?? 0} points",
                        height: height,
                        color: color,
                        image: friend.image ?? "",
                        showCrown: crown,
                      );
                    }),
                  ),
                );
              }),

              SizedBox(height: 12.h),

              Divider(
                color: isDark
                    ? AppDarkColors.iconColor
                    : AppLightColors.iconeColor,
                thickness: 1.h,
              ),

              SizedBox(height: 12.h),

              /// Tabs
              Obx(() {
                final tabs = ["Friends", "Global"];

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(tabs.length, (index) {
                    final isActive = controller.selectedTab.value == index;

                    return GestureDetector(
                      onTap: () => controller.changeTab(index),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 8.h,
                          horizontal: 16.w,
                        ),
                        decoration: BoxDecoration(
                          color: isActive
                              ? const Color(0xFFFFCEB3)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          tabs[index],
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: isActive
                                ? Colors.black
                                : isDark
                                ? AppDarkColors.primaryTextColor
                                : AppLightColors.primaryTextColor,
                          ),
                        ),
                      ),
                    );
                  }),
                );
              }),

              SizedBox(height: 10.h),

              /// Tab Content
              Obx(() {
                return SizedBox(
                  height: screenHeight * 0.5,
                  child: controller.selectedTab.value == 0
                      ? FriendsScreen(
                          skipTop3: true,
                        ) // Pass param to skip top 3
                      : GlobalScreen(),
                );
              }),
            ],
          ),
        ),
      );
    });
  }
}

// _LeaderboardItem remains same as before
class _LeaderboardItem extends StatelessWidget {
  final String position;
  final String name;
  final String points;
  final double height;
  final Color color;
  final String image;
  final bool showCrown;
  const _LeaderboardItem({
    required this.position,
    required this.name,
    required this.points,
    required this.height,
    required this.color,
    required this.image,
    this.showCrown = false,
  });
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.isDark.value;
    return SizedBox(
      width: 90.w,
      child: Column(
        children: [
          /// Points Above
          Text(
            points,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppDarkColors.primaryTextColor
                  : AppLightColors.primaryTextColor,
            ),
          ),
          SizedBox(height: 8.h),

          /// Profile + Crown (bounded height)
          SizedBox(
            height: 55.h,
            child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 0.h,
                  child: CircleAvatar(
                    radius: 35.r,
                    backgroundColor: Colors.grey.shade200,
                    child: ClipOval(
                      child: Image.network(
                        image,
                        width: 70.r,
                        height: 70.r,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            AppImages.defaultImage,
                            width: 70.r,
                            height: 70.r,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                ),

                if (showCrown)
                  Positioned(
                    top: -5.h,
                    left: 80.w,
                    child: SvgPicture.asset(
                      AppIcons.crownIcon,
                      height: 20.h,
                      width: 20.w,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 8.h),

          /// Main Pillar
          Container(
            height: height,
            width: 90.w,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.r),
                topRight: Radius.circular(40.r),
                bottomLeft: Radius.circular(12.r),
                bottomRight: Radius.circular(12.r),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 65.h,
                  width: 50.w,
                  margin: EdgeInsets.only(top: 6.h),
                  padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.w),
                  decoration: BoxDecoration(
                    color: AppDarkColors.primaryColor,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border(
                      bottom: BorderSide(color: Colors.black26, width: 6.w),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      position,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4.h),

                /// Name Container
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.w),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 14.sp, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
