import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/app_colours.dart';
import '../../../../core/app_icons.dart';
import '../controller/listen_image_controller.dart';

class ListenImageScreen extends StatelessWidget {
  ListenImageScreen({super.key});
  final ListenImageController controller = Get.put(ListenImageController());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          "Listen & Image",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select the correct answer",
              style: GoogleFonts.nunito(
                color: isDark ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
              ),
            ),
            SizedBox(height: 10.h),
            Center(
              child: SvgPicture.asset(AppIcons.sun, height: 70.h, width: 70.w),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    "assets/icons/sounds.svg",
                    height: 40.h,
                    width: 40.w,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    AppIcons.slow,
                    height: 40.h,
                    width: 40.w,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
