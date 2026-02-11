
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_icons.dart';
import 'package:online_study/constraints/app_images.dart';
import 'package:online_study/features/home/controller/lesson_controller.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/features/peer_screens/controller/follower_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class FollowerScreen extends StatelessWidget {
  FollowerScreen({super.key});
  final FollowerController controller = Get.put(FollowerController());
  final LessonController lessonController = Get.put(LessonController());
  final langController = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    controller.fetchFollowerList();

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
          } else if (controller.followers.isEmpty) {
            return Center(
              child: Text(
                langController.selectedLanguage["No followers found"] ?? "No followers found",
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
              itemCount: controller.followers.length,
              separatorBuilder: (context, index) => Divider(
                thickness: 1,
                color: isDark
                    ? AppDarkColors.borderLine
                    : AppLightColors.borderColor,
              ),
              itemBuilder: (context, index) {
                final follower = controller.followers[index];

                return ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 5.h,
                    horizontal: 10.w,
                  ),
                  leading: CircleAvatar(
                    radius: 25.r,
                    backgroundImage:
                        follower.image != null && follower.image!.isNotEmpty
                        ? NetworkImage(follower.image!)
                        : const AssetImage(AppImages.defaultImage)
                              as ImageProvider,
                  ),
                  title: Text(
                    follower.fullName ?? 'Unknown',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppDarkColors.primaryTextColor
                          : AppLightColors.iconeColor,
                    ),
                  ),
                  subtitle: Text(
                    lessonController.user.value?.levelOfFluncy ?? '',
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
