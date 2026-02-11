import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';

class StatsCard extends StatelessWidget {
  final String title;
  final bool isDark;
  final List<IconTextPair> items;

  const StatsCard({
    super.key,
    required this.title,
    required this.isDark,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppDarkColors.primaryColor.withOpacity(0.5),
          width: 2.w,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: isDark ? AppDarkColors.primaryTextColor : AppLightColors.primaryTextColor,
            ),
          ),
          // map icon-text pairs
          ...items.map(
                (item) => Row(
              children: [
                SvgPicture.asset(
                  item.iconPath,
                  height: 15.h,
                  width: 15.w,
                ),
                SizedBox(width: 5.w),
                Text(
                  item.text,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark ?  AppDarkColors.primaryTextColor : AppLightColors.primaryTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Helper class to pass icon + text
class IconTextPair {
  final String iconPath;
  final String text;

  IconTextPair({required this.iconPath, required this.text});
}
