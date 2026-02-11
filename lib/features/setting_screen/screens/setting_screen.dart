
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/components/custom_button_widget.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_icons.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/features/setting_screen/controller/setting_controller.dart';
import 'package:online_study/features/setting_screen/screens/daily_goals_screen.dart';
import 'package:online_study/features/setting_screen/screens/manage_account_screen.dart';
import 'package:online_study/features/setting_screen/screens/native_language_screen.dart';
import 'package:online_study/features/welcome/ui/screens/welcome_screen.dart';
import 'package:online_study/services/shared_preferences_helper.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  final SettingController controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final langController = Get.find<LanguageController>();
    return Obx(() {
      final isDark = themeController.isDark.value;

      return Scaffold(
        backgroundColor: isDark
            ? AppDarkColors.backgroundColor
            : AppLightColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: isDark
              ? AppDarkColors.backgroundColor
              : AppLightColors.backgroundColor,
          elevation: 0,
          scrolledUnderElevation: 0,
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
            langController.selectedLanguage["Settings"] ?? "Settings",
            style: GoogleFonts.inter(
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
                langController.selectedLanguage["Account"] ?? "Account",
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppDarkColors.primaryColor,
                ),
              ),
              SizedBox(height: 10.h),
              SettingTile(
                icon: Icons.person,
                title: langController.selectedLanguage["Manage Account"] ?? "Manage Account",
                onTap: () {
                  
                  Get.to(() => ManageAccountScreen());
                },
                iconColor: AppDarkColors.primaryColor,
                textColor: isDark
                    ? AppDarkColors.primaryTextColor
                    : AppLightColors.primaryTextColor,
                arrowColor: AppDarkColors.primaryColor,
              ),
              SizedBox(height: 5.h),
              Divider(thickness: 1, color: AppDarkColors.lightGrayTextColor),
              SizedBox(height: 10.h),

              // Learning Preferences Section
              Text(
                langController.selectedLanguage["Learning Preferences"] ?? "Learning Preferences",
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppDarkColors.primaryColor,
                ),
              ),
              SizedBox(height: 10.h),
              SettingTile(
                icon: Icons.language,
                title: langController.selectedLanguage["Native Language"] ?? "Native Language",
                onTap: () {
                  Get.to(() => NativeLanguageScreen());
                },
                iconColor: AppDarkColors.primaryColor,
                textColor: isDark
                    ? AppDarkColors.primaryTextColor
                    : AppLightColors.primaryTextColor,
                arrowColor: AppDarkColors.primaryColor,
              ),
              // SizedBox(height: 5.h),
              // SettingTile(
              //   icon: Icons.flag,
              //   title: "Switch Course",
              //   onTap: () {
              //     Get.to(() => SwitchCourseScreen());
              //   },
              //   iconColor: AppDarkColors.primaryColor,
              //   textColor: isDark
              //       ? AppDarkColors.primaryTextColor
              //       : AppLightColors.primaryTextColor,
              //   arrowColor: AppDarkColors.primaryColor,
              // ),
              SizedBox(height: 5.h),
              SettingTile(
                image: AppIcons.goal,
                title: langController.selectedLanguage["Daily Goal"] ?? "Daily Goal",
                onTap: () {
                  Get.to(() => DailyGoalsScreen());
                },
                iconColor: AppDarkColors.primaryColor,
                textColor: isDark
                    ? AppDarkColors.primaryTextColor
                    : AppLightColors.primaryTextColor,
                arrowColor: AppDarkColors.primaryColor,
              ),

              SizedBox(height: 5.h),
              Divider(thickness: 1, color: AppDarkColors.lightGrayTextColor),
              SizedBox(height: 10.h),
              Text(
                langController.selectedLanguage["General"] ?? "General",
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppDarkColors.primaryColor,
                ),
              ),
              SizedBox(height: 10.h),
              _SettingTile(
                image: AppIcons.agun,
                title: langController.selectedLanguage['Streak notification'] ?? 'Streak notification',
                textColor: isDark
                    ? AppDarkColors.primaryTextColor
                    : AppLightColors.primaryTextColor,
                value: controller.notificationsEnabled.value,
                onChanged: controller.toggleNotifications,
              ),
              SizedBox(height: 5.h),
              _SettingTile(
  image: AppIcons.ranking,
  title: langController.selectedLanguage['Ranking'] ?? 'Ranking',
  textColor: isDark
      ? AppDarkColors.primaryTextColor
      : AppLightColors.primaryTextColor,
  value: true, // সবসময় true
  onChanged: (bool value) {}, // disabled switch
),

              SizedBox(height: 5.h),
              _SettingTile(
                image: AppIcons.theme,
                title: langController.selectedLanguage['Mode'] ?? 'Mode',
                textColor: isDark
                    ? AppDarkColors.primaryTextColor
                    : AppLightColors.primaryTextColor,
                value: themeController.isDark.value,
                onChanged: (value) {
                  themeController.toggleTheme();
                  Get.forceAppUpdate();
                },
              ),
              SizedBox(height: 5.h),
              Divider(thickness: 1, color: AppDarkColors.lightGrayTextColor),
              SizedBox(height: 10.h),
              GestureDetector(
                onTap: () {
                  _showDialog(context);
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.logout,
                      height: 30.h,
                      width: 30.w,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      langController.selectedLanguage["Logout"] ?? "Logout",
                      style: GoogleFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: AppDarkColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void _showDialog(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final langController = Get.find<LanguageController>();
    final isDark = themeController.isDark.value;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDark
              ? AppDarkColors.backgroundColor
              : AppLightColors.backgroundColor,
          title: Text(
            langController.selectedLanguage['Logout'] ?? 'Logout',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: AppDarkColors.primaryColor,
            ),
          ),
          content: Text(
            langController.selectedLanguage['Are you sure you want to logout?'] ?? 'Are you sure you want to logout?',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          actions: [
            CustomButtonWidget(
              width: 100.w,
              height: 35.h,
              text: "Cancel",
              onTap: () {
                Get.back();
              },
              backgroundColor: AppDarkColors.primaryColor,
              borderColor: Colors.transparent,
            ),
            SizedBox(width: 10.w),
            CustomButtonWidget(
              width: 100.w,
              height: 35.h,
              text: "Logout",
              onTap: () {
                SharedPreferencesHelper.clearAccessToken();
                Get.offAll(() => WelcomeScreen());
              },
              backgroundColor: AppDarkColors.primaryColor,
              borderColor: Colors.transparent,
            ),
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
                  style: GoogleFonts.inter(
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
                style: GoogleFonts.inter(
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
            activeThumbColor: Colors.white,
            activeTrackColor: AppDarkColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
