
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../component/custom_widgets/custom_button.dart';
import '../../../component/custom_widgets/custom_text_field.dart';
import '../../../core/app_colours.dart';
import '../../../core/app_icons.dart';
import '../controller/account_controller.dart';

class ManageAccountScreen extends StatelessWidget {
  final AccountController controller = Get.put(AccountController());
  ManageAccountScreen({super.key});

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
          "Manage Account",
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
            Row(
              children: [
                Obx(() {
                  return GestureDetector(
                    onTap: () {
                      controller.pickImageGalary();
                    },
                    child: CircleAvatar(
                      radius: 50.r,
                      backgroundColor: AppColors.borderLine,
                      backgroundImage: controller.selectedImage.value != null
                          ? FileImage(controller.selectedImage.value!)
                          : null,
                      child: controller.selectedImage.value == null
                          ? Icon(
                              Icons.camera_alt,
                              size: 30.sp,
                              color: AppColors.btnBG,
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
                        Text(
                          "Name",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: isDark ? AppColors.bgLight : Colors.black,
                          ),
                        ),
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
                    Text(
                      "Joined Oct 7 2025",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: isDark ? AppColors.bgLight : Colors.black,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      "Login method: Google",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: isDark ? AppColors.bgLight : Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Divider(
              thickness: 1,
              color: isDark ? AppColors.bgLight : Colors.black12,
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                Icon(Icons.email, size: 25.sp, color: AppColors.btnBG),
                SizedBox(width: 10.w),
                Text(
                  "xyz@hmail.com",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? AppColors.bgLight : Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.person, size: 25.sp, color: AppColors.btnBG),
                    SizedBox(width: 10.w),
                    Text(
                      "Account Type : ",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: isDark ? AppColors.bgLight : Colors.black,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      "Premium",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.btnBG,
                      ),
                    ),
                  ],
                ),
                SvgPicture.asset(AppIcons.taj),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showTextDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final AccountController controller = Get.find<AccountController>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            width: 300.w, // maximum width of dialog
            child: Padding(
              padding: EdgeInsets.all(15.w),
              child: Column(
                mainAxisSize: MainAxisSize.min, // wrap content vertically
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Change Username',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppColors.bgLight : Colors.black,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  CustomTextField(
                    textEditingController: controller.nameController,
                    fillColor: Colors.transparent,
                    hintText: "Enter name",
                    hintTextColor: isDark ? Colors.white : AppColors.lightText,
                    textColor: isDark ? Colors.white : AppColors.lightText,
                    borderSide: BorderSide(
                      color: isDark ? Colors.white : AppColors.lightText,
                      width: 1.w,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomButton(
                      text: "Submit",
                      width: 100.w,
                      onTap: () {

                      },
                      backgroundColor: AppColors.btnBG,
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
