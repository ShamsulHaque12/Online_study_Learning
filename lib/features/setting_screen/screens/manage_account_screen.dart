
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/components/custom_button_widget.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_icons.dart';
import 'package:online_study/features/home/controller/lesson_controller.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/features/setting_screen/controller/manage_account_screen_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class ManageAccountScreen extends StatelessWidget {
  ManageAccountScreen({super.key});
  final ManageAccountScreenController controller = Get.put(
    ManageAccountScreenController(),
  );
  final LessonController lessonController = Get.find<LessonController>();
  final langController = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
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
          langController.selectedLanguage["Manage Account"] ?? "Manage Account",
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
            Row(
              children: [
                Obx(() {
                  return GestureDetector(
                    onTap: () {
                      controller.pickImageGallery();
                    },
                    child: CircleAvatar(
                      radius: 50.r,
                      backgroundColor: AppDarkColors.textFieldBorderColor,
                      backgroundImage: controller.selectedImage.value != null
                          ? FileImage(controller.selectedImage.value!)
                          : null,
                      child: controller.selectedImage.value == null
                          ? GestureDetector(
                              onTap: () {
                                controller.pickImageGallery();
                              },
                              child: Icon(
                                Icons.camera_alt,
                                size: 30.sp,
                                color: AppDarkColors.tealColor,
                              ),
                            )
                          : null,
                    ),
                  );
                }),
                SizedBox(width: 15.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Obx(() {
                          return Text(
                            lessonController.user.value?.fullName ??
                                "Full Name",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: isDark
                                  ? AppDarkColors.primaryTextColor
                                  : AppLightColors.primaryTextColor,
                            ),
                          );
                        }),

                        SizedBox(width: 10.w),
                        GestureDetector(
                          onTap: () {
                            _showTextDialog(context);
                          },
                          child: SvgPicture.asset(
                            AppIcons.text_edit,
                            height: 20.h,
                            width: 20.w,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Obx(() {
                      final user = lessonController.user.value;
                      String joinedText = "Joined";
                      if (user?.createdAt != null) {
                        final date = DateTime.tryParse(user!.createdAt!);
                        if (date != null) {
                          joinedText =
                              "Joined ${_monthName(date.month)} ${date.year}";
                        }
                      }
                      return Text(
                        joinedText,
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: isDark
                              ? AppDarkColors.lightGrayTextColor
                              : AppLightColors.grayTextColor,
                        ),
                      );
                    }),
                    SizedBox(height: 5.h),
                    Text(
                      "Login method: Google",
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: isDark
                            ? AppDarkColors.lightGrayTextColor
                            : AppLightColors.grayTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Divider(thickness: 1, color: AppDarkColors.lightGrayTextColor),
            SizedBox(height: 15.h),
            Row(
              children: [
                Icon(
                  Icons.email,
                  size: 25.sp,
                  color: AppDarkColors.primaryColor,
                ),
                SizedBox(width: 10.w),
                Obx(() {
                  return Text(
                    lessonController.user.value?.email ?? "Email",
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: isDark
                          ? AppDarkColors.primaryTextColor
                          : AppLightColors.primaryTextColor,
                    ),
                  );
                }),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 25.sp,
                      color: AppDarkColors.primaryColor,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      langController.selectedLanguage["Account Type : "] ?? "Account Type : ",
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? AppDarkColors.primaryTextColor
                            : AppLightColors.primaryTextColor,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      "Premium",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppDarkColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                SvgPicture.asset(AppIcons.crownIcon),
              ],
            ),
          ],
        ),
      ),
    );
    });
  }

  String _monthName(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return months[month - 1];
  }

  void _showTextDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ManageAccountScreenController controller =
        Get.find<ManageAccountScreenController>();
        final langController = Get.find<LanguageController>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDark
              ? AppDarkColors.backgroundColor
              : AppLightColors.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            width: 300.w,
            child: Padding(
              padding: EdgeInsets.all(15.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    langController.selectedLanguage['Change Username'] ?? 'Change Username',
                    style: GoogleFonts.inter(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  TextFormField(
                    controller: controller.nameController,
                    decoration: InputDecoration(hintText: "Enter your name"),
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomButtonWidget(
                      text: "Submit",
                      width: 100.w,
                      onTap: () {
                        controller.updateUserProfile();
                        Get.back();
                      },
                      backgroundColor: AppDarkColors.primaryColor,
                      borderColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
