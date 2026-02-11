
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_icons.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/features/peer_screens/controller/follower_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class FollowingScreen extends StatelessWidget {
  FollowingScreen({super.key});

  final FollowerController controller = Get.put(FollowerController());

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final langController = Get.find<LanguageController>();
    controller.fetchFollowingList();

    return Obx(() {
      final isDark = themeController.isDark.value;
      return Scaffold(
        backgroundColor: isDark
            ? AppDarkColors.backgroundColor
            : AppLightColors.backgroundColor,
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: SpinKitCircle(color: AppDarkColors.primaryColor),
            );
          } else if (controller.following.isEmpty) {
            return Center(
              child: Text(
                langController.selectedLanguage["No following found"] ?? "No following found",
                style: TextStyle(
                  color: isDark
                      ? AppDarkColors.primaryTextColor
                      : AppLightColors.primaryTextColor,
                ),
              ),
            );
          } else {
            return ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: controller.following.length,
              separatorBuilder: (context, index) => Divider(
                thickness: 1,
                color: isDark
                    ? AppDarkColors.borderLine
                    : AppLightColors.borderColor,
              ),
              itemBuilder: (context, index) {
                final user = controller.following[index];

                return ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 5.h,
                    horizontal: 10.w,
                  ),
                  leading: CircleAvatar(
  radius: 25.r,
  backgroundImage: NetworkImage(
    (user.image != null && user.image!.isNotEmpty)
        ? user.image!
        : 'https://www.w3schools.com/howto/img_avatar.png', // default network avatar
  ),
),
                  title: Text(
                    user.fullName ?? 'Unknown',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppDarkColors.primaryTextColor
                          : AppLightColors.iconeColor,
                    ),
                  ),
                  subtitle: Text(
                    'Points: ${user.totalPoints ?? 0}',
                    style: GoogleFonts.inter(
                      color: isDark
                          ? AppDarkColors.primaryTextColor
                          : AppLightColors.lightGrayTextColor,
                    ),
                  ),
                  trailing: SvgPicture.asset(
                    AppIcons.arrow,
                    color: isDark
                        ? AppDarkColors.iconColor
                        : AppLightColors.iconeColor,
                  ),
                );
              },
            );
          }
        }),
      );
    });
  }
}
