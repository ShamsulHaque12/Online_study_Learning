import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/app_colours.dart';
import '../controller/mastery_controller.dart';

class MasteryScreen extends StatelessWidget {
  MasteryScreen({super.key});
  final MasteryController controller = Get.put(MasteryController());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Chapter",
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.bgLight : AppColors.lightText,
            ),
          ),
          SizedBox(height: 10.h),

          /// Linear Progress Bar..................
          Row(
            children: [
              SvgPicture.asset(
                "assets/icons/one.svg",
                height: 20.h,
                width: 20.w,
              ),
              SizedBox(width: 10.w),

              Expanded(
                child: Obx(() {
                  double value = controller.progress.value;
                  int orange = (value * 100).toInt();
                  int gray = 100 - orange;

                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: SizedBox(
                      height: 10.h,
                      child: Row(
                        children: [
                          Expanded(
                            flex: orange,
                            child: Container(color: Colors.orange),
                          ),

                          Expanded(
                            flex: gray,
                            child: Container(color: Colors.grey[300]),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),

              SizedBox(width: 10.w),
              SvgPicture.asset(
                "assets/icons/two.svg",
                height: 20.h,
                width: 20.w,
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            "100 point to next Chapter",
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.bgLight : AppColors.gray,
            ),
          ),
          SizedBox(height: 15.h),

          /// Circle Progress Bar.................
          Center(
            child: Obx(() {
              double value = controller.circleProgress.value;

              return SizedBox(
                height: 150.w,
                width: 150.w,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    /// Background Circle
                    SizedBox(
                      height: 150.w,
                      width: 150.w,
                      child: CircularProgressIndicator(
                        value: 1,
                        strokeWidth: 18.w,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isDark ? Color(0xFFCED4DA) : AppColors.borderLine,
                        ),
                      ),
                    ),

                    /// Progress Circle
                    SizedBox(
                      height: 150.w,
                      width: 150.w,
                      child: CircularProgressIndicator(
                        value: value,
                        strokeWidth: 18.w,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.grammer,
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                    ),

                    /// Center Text
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${(value * 100).toInt()}%",
                          style: GoogleFonts.inter(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.orange,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          "Completed",
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
          SizedBox(height: 15.h),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "You've mastered ",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? AppColors.bgLight : AppColors.lightText,
                  ),
                ),
                TextSpan(
                  text: "${(controller.circleProgress.value * 100).toInt()}%",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.orange,
                  ),
                ),
                TextSpan(
                  text: " of your Filipino learning journey!",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? AppColors.bgLight : AppColors.lightText,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
