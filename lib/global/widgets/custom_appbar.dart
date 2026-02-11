
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_icons.dart';
import 'package:online_study/constraints/app_images.dart';
import 'package:online_study/features/home/controller/lesson_controller.dart';
import 'package:online_study/route/app_routes.dart';
import 'package:online_study/services/api_endpoints.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int fireCount;
  final int notoCount;
  final VoidCallback? onLanguagePressed;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onProfilePressed;

  CustomAppBar({
    super.key,
    this.fireCount = 2,
    this.notoCount = 100,
    this.onLanguagePressed,
    this.onNotificationPressed,
    this.onProfilePressed,
  });
  final LessonController lessonController = Get.find<LessonController>();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      backgroundColor: isDarkMode
          ? AppDarkColors.backgroundColor
          : AppLightColors.backgroundColor,
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppIcons.fireIcon, height: 20.h, width: 20.w),
          SizedBox(width: 4.w),
          Text(
            '$fireCount',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              color: isDarkMode
                  ? AppDarkColors.primaryColor
                  : AppLightColors.primaryColor,
            ),
          ),
          SizedBox(width: 12.w),
          SvgPicture.asset(AppIcons.notoIcon, height: 20.h, width: 20.w),
          SizedBox(width: 4.w),
          Text(
            '$notoCount',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              color: isDarkMode
                  ? AppDarkColors.primaryColor
                  : AppLightColors.primaryColor,
            ),
          ),
        ],
      ),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 8.w),
          SvgPicture.asset(AppIcons.englishFlag),
        ],
      ),
      leadingWidth: 100.w,
      actions: [
        IconButton(
          onPressed:
              onNotificationPressed ??
              () {
                Get.toNamed(AppRoutes.notificationScreen);
              },
          icon: Icon(Icons.notifications),
        ),
        Obx(() {
          final user = lessonController.user.value;
          final imageUrl = resolveUserImage(user?.image);

          debugPrint("OBX IMAGE URL => $imageUrl");

          return CircleAvatar(
            radius: 18.r,
            child: ClipOval(
              child: Image(
                width: 36.r,
                height: 36.r,
                fit: BoxFit.cover,
                image: imageUrl != null
                    ? NetworkImage(imageUrl)
                    : const AssetImage(AppImages.avator),
                errorBuilder: (_, __, ___) {
                  debugPrint("IMAGE LOAD FAILED");
                  return Image.asset(AppImages.avator);
                },
              ),
            ),
          );
        }),

        // CircleAvatar(radius: 18.r),
        SizedBox(width: 12.w),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  String? resolveUserImage(String? imagePath) {
    debugPrint("RAW IMAGE PATH => $imagePath");

    if (imagePath == null || imagePath.isEmpty) {
      debugPrint("IMAGE RESULT => NULL (empty or null)");
      return null;
    }

    if (imagePath.contains('undefined')) {
      debugPrint("IMAGE RESULT => NULL (contains undefined)");
      return null;
    }

    if (imagePath.startsWith('http')) {
      debugPrint("IMAGE FINAL URL => $imagePath");
      return imagePath;
    }

    final fullUrl = "${ApiEndpoints.baseUrl}$imagePath";
    debugPrint("IMAGE FINAL URL => $fullUrl");

    return fullUrl;
  }
}
