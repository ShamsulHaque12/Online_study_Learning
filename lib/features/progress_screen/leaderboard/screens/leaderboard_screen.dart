
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/app_colours.dart';
import '../../../../core/app_icons.dart';
import '../controller/leader_board_controller.dart';
import 'friends_screen.dart';
import 'global_screen.dart';

class LeaderboardScreen extends StatelessWidget {
  LeaderboardScreen({super.key});
  final LeaderBoardController controller = Get.put(LeaderBoardController());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
          child: Column(
            children: [
              /// Leaderboard Row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _LeaderboardItem(
                      position: "2",
                      name: "Camelia",
                      points: "992 points",
                      height: 180.h,
                      color: const Color(0xFF884F35),
                      image: "https://i.imgur.com/BoN9kdC.png",
                    ),
                    SizedBox(width: 12.w),
                    _LeaderboardItem(
                      position: "1",
                      name: "Maxwell",
                      points: "992 points",
                      height: 220.h,
                      color: const Color(0xFF00A7A7),
                      image: "https://i.imgur.com/2yaf2wb.png",
                      showCrown: true,
                    ),
                    SizedBox(width: 12.w),
                    _LeaderboardItem(
                      position: "3",
                      name: "Wilson",
                      points: "992 points",
                      height: 150.h,
                      color: const Color(0xFFDF6B38),
                      image: "https://i.imgur.com/tEcsk5u.png",
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12.h),
              Divider(
                color: isDark ? AppColors.bgLight : AppColors.borderLine,
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
                        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: isActive ? Color(0xFFFFCEB3) : Colors.transparent,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          tabs[index],
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: isActive ? Colors.black : isDark ? AppColors.bgLight : AppColors.lightText,
                          ),
                        ),
                      ),
                    );
                  }),
                );
              }),

              SizedBox(height: 10.h),

              /// TAB CONTENT
              Obx(() {
                return SizedBox(
                  height: screenHeight * 0.5,
                  child: switch (controller.selectedTab.value) {
                    0 => FriendsScreen(),
                    1 => GlobalScreen(),
                    _ => FriendsScreen(),
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

}

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      width: 100.w,
      child: Column(
        children: [
          /// Points Above
          Text(
            points,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.bgLight : AppColors.lightText,
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
                    backgroundImage: NetworkImage(image),
                  ),
                ),
                if (showCrown)
                  Positioned(
                    top: -5.h,
                    left: 80.w,
                    child: SvgPicture.asset(
                      AppIcons.taj,
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
            width: 100.w,
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
                  margin: EdgeInsets.only(top: 6.h),
                  padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.w),
                  decoration: BoxDecoration(
                    color: AppColors.text2,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    position,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
