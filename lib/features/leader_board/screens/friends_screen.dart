// FriendsScreen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/leader_board/controller/leader_board_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class FriendsScreen extends StatelessWidget {
  final bool skipTop3;
  FriendsScreen({super.key, this.skipTop3 = false});

  final LeaderBoardController controller = Get.put(LeaderBoardController());

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(() {
    final isDark = themeController.isDark.value;
      if (controller.friends.isEmpty) {
        return Center(child: SpinKitCircle(color: AppDarkColors.primaryColor));
      }

      // Sort by points descending
      final sorted = List.of(controller.friends);
      sorted.sort((a, b) => (b.totalPoints ?? 0).compareTo(a.totalPoints ?? 0));

      // Skip top 3 if needed
      final list = skipTop3 && sorted.isNotEmpty ? sorted.sublist(0) : sorted;

      return ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: list.length,
        separatorBuilder: (_, __) => SizedBox(height: 10.h),
        itemBuilder: (context, index) {
          final friend = list[index];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Index number
              Text(
                "${skipTop3 ? index + 1 : index + 1}.",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark
                      ? AppDarkColors.primaryTextColor
                      : AppLightColors.primaryTextColor,
                ),
              ),
              SizedBox(width: 10.w),

              // Avatar + Name
              CircleAvatar(
                radius: 15.r,
                backgroundImage:
                    friend.image != null && friend.image!.isNotEmpty
                    ? NetworkImage(friend.image!)
                    : null,
                child: (friend.image == null || friend.image!.isEmpty)
                    ? Icon(Icons.person, size: 16.sp)
                    : null,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  friend.fullName ?? "—",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppDarkColors.primaryTextColor
                        : AppLightColors.primaryTextColor,
                  ),
                ),
              ),

              // Points
              Text(
                "${friend.totalPoints ?? 0} points",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: isDark
                      ? AppDarkColors.primaryTextColor
                      : AppLightColors.primaryTextColor,
                ),
              ),
            ],
          );
        },
      );
    });
  }
}
