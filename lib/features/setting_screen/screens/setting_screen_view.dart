
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:online_study/features/setting_screen/screens/switch_course_screen.dart';
import 'package:online_study/features/setting_screen/screens/theme_mode_screen.dart';
import '../../../component/custom_widgets/custom_button.dart';
import '../../../core/app_colours.dart';
import '../../../core/app_icons.dart';
import '../controller/setting_controller.dart';
import 'daily_goals_screen.dart';
import 'manage_account_screen.dart';
import 'native_language_screen.dart';

class SettingScreenView extends StatelessWidget {
  final SettingController controller = Get.put(SettingController());
  SettingScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          "Settings",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Section
            Text(
              "Account",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.btnBG,
              ),
            ),
            SizedBox(height: 10.h),
            SettingTile(
              icon: Icons.person,
              title: "Manage Account",
              onTap: () {
                Get.to(()=>ManageAccountScreen());
              },
              iconColor: AppColors.btnBG,
              textColor: isDark ? AppColors.bgLight : Colors.black,
              arrowColor: AppColors.btnBG,
            ),
            SizedBox(height: 5.h),
            Divider(
              thickness: 1,
              color: isDark
                  ? AppColors.bgLight.withOpacity(0.5)
                  : Colors.black12,
            ),
            SizedBox(height: 10.h),

            // Learning Preferences Section
            Text(
              "Learning Preferences",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.btnBG,
              ),
            ),
            SizedBox(height: 10.h),
            SettingTile(
              icon: Icons.language,
              title: "Native Language",
              onTap: () {
                Get.to(()=>NativeLanguageScreen());
              },
              iconColor: AppColors.btnBG,
              textColor: isDark ? AppColors.bgLight : Colors.black,
              arrowColor: AppColors.btnBG,
            ),
            SizedBox(height: 5.h),
            SettingTile(
              icon: Icons.flag,
              title: "Switch Course",
              onTap: () {
                Get.to(()=>SwitchCourseScreen());
              },
              iconColor: AppColors.btnBG,
              textColor: isDark ? AppColors.bgLight : Colors.black,
              arrowColor: AppColors.btnBG,
            ),
            SizedBox(height: 5.h),
            SettingTile(
              image: AppIcons.goal,
              title: "Daily Goal",
              onTap: () {
                Get.to(()=>DailyGoalsScreen());
              },
              iconColor: AppColors.btnBG,
              textColor: isDark ? AppColors.bgLight : Colors.black,
              arrowColor: AppColors.btnBG,
            ),
            SizedBox(height: 5.h),
            SettingTile(
              image: AppIcons.theme,
              title: "Mode",
              onTap: () {
                Get.to(()=>ThemeModeScreen());
              },
              iconColor: AppColors.btnBG,
              textColor: isDark ? AppColors.bgLight : Colors.black,
              arrowColor: AppColors.btnBG,
            ),
            SizedBox(height: 5.h),
            Divider(
              thickness: 1,
              color: isDark
                  ? AppColors.bgLight.withOpacity(0.5)
                  : Colors.black12,
            ),
            SizedBox(height: 10.h),
            Text(
              "General",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.btnBG,
              ),
            ),
            SizedBox(height: 10.h),
            Obx(
              () => _SettingTile(
                image: AppIcons.agun,
                title: 'Streak notification',
                textColor: isDark ? AppColors.bgLight : Colors.black,
                value: controller.notificationsEnabled.value,
                onChanged: controller.toggleNotifications,
              ),
            ),
            SizedBox(height: 5.h),
            Obx(
              () => _SettingTile(
                image: AppIcons.ranking,
                title: 'Ranking',
                textColor: isDark ? AppColors.bgLight : Colors.black,
                value: controller.rankingEnabled.value,
                onChanged: controller.toggleRanking,
              ),
            ),
            SizedBox(height: 5.h),
            Divider(
              thickness: 1,
              color: isDark
                  ? AppColors.bgLight.withOpacity(0.5)
                  : Colors.black12,
            ),
            SizedBox(height: 10.h),
            GestureDetector(
              onTap: (){
                _showDialog(context);
              },
              child: Row(
                children: [
                  SvgPicture.asset(AppIcons.logout,height: 30.h,width: 30.w,),
                  SizedBox(width: 10.w),
                  Text("Logout",style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.btnBG,
                  ),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
          title: Text('Logout',style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.btnBG,
          ),),
          content: Text('Are you sure you want to logout?',style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: isDark ? AppColors.bgLight : Colors.black,
          ),),
          actions: [
            CustomButton(
              width: 100.w,
              height: 35.h,
              text: "Cancel",
              onTap: (){
                Get.back();
              },
              backgroundColor: AppColors.btnBG,
              borderColor: Colors.transparent,
            ),
            SizedBox(width: 10.w),
            CustomButton(
              width: 100.w,
              height: 35.h,
              text: "Logout",
              onTap: (){
                Get.back();
              },
              backgroundColor: AppColors.btnBG,
              borderColor: Colors.transparent,
            )
          ],
        );
      },
    );
  }
}

class SettingTile extends StatelessWidget {
  final IconData? icon;
  final String? image;
  final String title;
  final VoidCallback onTap;
  final Color iconColor;
  final Color textColor;
  final Color arrowColor;

  const SettingTile({
    super.key,
    this.icon,
    this.image,
    required this.title,
    required this.onTap,
    required this.iconColor,
    required this.textColor,
    required this.arrowColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // Icon or SVG Image
                if (icon != null)
                  Icon(icon, size: 20.sp, color: iconColor)
                else if (image != null)
                  SvgPicture.asset(
                    image!,
                    height: 20.h,
                    width: 20.w,
                    color: iconColor,
                  ),
                SizedBox(width: 10.w),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios, size: 25.sp, color: arrowColor),
          ],
        ),
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  final String title;
  final bool value;
  final String image;
  final Color textColor;
  final ValueChanged<bool> onChanged;

  const _SettingTile({
    required this.title,
    required this.textColor,
    required this.value,
    required this.image,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(image, height: 20.h, width: 20.w),
              SizedBox(width: 10.w),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: AppColors.btnBG,
          ),
        ],
      ),
    );
  }
}
