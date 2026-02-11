import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';

class LessonChapterContainer extends StatelessWidget {
  final String chapterTitle;
  final String? chapterSubtitle;
  final String progressText;
  final Color containerColor;
  final VoidCallback? onPressed;
  const LessonChapterContainer({
    super.key,
    required this.chapterTitle,
    this.chapterSubtitle,
    required this.progressText,
    required this.containerColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      //  padding: EdgeInsets.only(right: 50.w),
      // padding: EdgeInsets.zero,
      padding: EdgeInsets.only(right: screenWidth * 0.132),
      child: GestureDetector(
        onTap: onPressed,
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  // height: 110.h,
                  height: height * 0.18,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: Text(
                          chapterTitle,
                          style: GoogleFonts.inter(
                            color: isDarkMode
                                ? AppDarkColors.orangeTextColor
                                : AppLightColors.orangeTextColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      if (chapterSubtitle != null) ...[
                        SizedBox(height: 4.h),
                        Padding(
                          padding: const EdgeInsets.only(right: 50),
                          child: Text(
                            chapterSubtitle!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.nunito(
                              color: isDarkMode
                                  ? AppDarkColors.welButtonBackColor
                                  : AppLightColors.buttonTextColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Positioned(
                  top: 0.h,
                  bottom: 0.h,
                  right: -50.w,
                  child: Center(
                    child: Container(
                      width: 115.w,
                      height: 115.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: containerColor, width: 3.w),
                      ),
                      child: Center(
                        child: Text(
                          progressText,
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
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
