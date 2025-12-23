import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../core/app_colours.dart';
import '../../../core/app_icons.dart';
import '../../../core/app_images.dart';
import '../controller/peer_controller.dart';

class ChangeScreenView extends StatelessWidget {
  final PeerController controller = Get.put(PeerController());
  ChangeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network('https://flagcdn.com/w80/gb.png'),
        ),
        elevation: 0,
        actions: [
          SvgPicture.asset(AppIcons.agun, height: 20.h, width: 20.w),
          const SizedBox(width: 5),
          Text(
            "2",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : AppColors.lightText,
            ),
          ),
          const SizedBox(width: 10),
          SvgPicture.asset(AppIcons.egg, height: 20.h, width: 20.w),
          const SizedBox(width: 5),
          Text(
            "2",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : AppColors.lightText,
            ),
          ),
          const SizedBox(width: 70),
          SvgPicture.asset(
            AppIcons.notification,
            height: 20.h,
            width: 20.w,
            color: isDark ? Colors.white : AppColors.lightText,
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 20.r,
            backgroundImage: AssetImage(AppImages.putul),
          ),
          const SizedBox(width: 10),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: Colors.orange, width: 2.w),
              ),
              child: Obx(
                    () => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      buildTab("Follower", 0),
                      SizedBox(width: 10),
                      buildTab("Following", 1),
                      SizedBox(width: 10),
                      buildTab("Find friend", 2),
                      SizedBox(width: 10),
                      buildTab("Chat", 3),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.h),

            Expanded(
              child: Obx(
                () => controller.screens[controller.selectedIndex.value],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tab Button
  Widget buildTab(String title, int index) {
    bool isActive = controller.selectedIndex.value == index;

    return GestureDetector(
      onTap: () => controller.selectedIndex.value = index,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? Colors.orange : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}
