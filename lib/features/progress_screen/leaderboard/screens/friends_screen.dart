import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/app_colours.dart';
import '../controller/leader_board_controller.dart';

class FriendsScreen extends StatelessWidget {
  FriendsScreen({super.key});
  final controller = Get.put(LeaderBoardController());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Obx(() {
      if (controller.friends.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }

      return ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.friends.length,
        separatorBuilder: (_, __) => SizedBox(height: 10.h),
        itemBuilder: (context, index) {
          final friend = controller.friends[index];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Index number
              Text(
                "${index + 1}.",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.bgLight : AppColors.lightText,
                ),
              ),
              SizedBox(width: 10.w),

              // Avatar + Name
              CircleAvatar(
                radius: 15.r,
                backgroundImage: NetworkImage(friend.image),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  friend.name,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.bgLight : AppColors.lightText,
                  ),
                ),
              ),

              // Points
              Text(
                "${friend.point} points",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: isDark ? AppColors.bgLight : AppColors.lightText,
                ),
              ),
            ],
          );
        },
      );
    });
  }
}
