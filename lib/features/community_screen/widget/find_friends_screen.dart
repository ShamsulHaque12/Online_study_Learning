import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:share_plus/share_plus.dart';
import '../../../component/custom_widgets/custom_text_field.dart';
import '../../../core/app_colours.dart';
import '../controller/find_friend_controller.dart';

class FindFriendsScreen extends StatelessWidget {
  final FindFriendController controller = Get.put(FindFriendController());
  FindFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Invite Friends",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 10.h),
            CustomTextField(
              textEditingController: controller.searchController,
              hintText: "Search",
              hintTextColor: AppColors.btnTextBule,
              fillColor: Colors.transparent,
              borderSide: BorderSide(color: AppColors.btnTextBule, width: 1),
            ),
            SizedBox(height: 10.h),
            GestureDetector(
              onTap: () {
                Share.share(
                    "Download my app: https://play.google.com/store/apps/details?id=your.app",
                    subject: "My App Link"
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/link.svg",
                    height: 15.h,
                    width: 15.w,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    "Copy invite link",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.btnTextBule,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
