import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';

class TabStatusItem extends StatelessWidget {
  final String icon;
  final String label;
  final String value;
  final bool isSelected;

  const TabStatusItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.1,
      width: 100.w,
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xffCCFFFE) : Colors.transparent,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// TOP ROW (icon + value)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(icon, height: 20.h, width: 20.w),
              SizedBox(width: 5.w),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  color: AppDarkColors.textColors2,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),

          /// LABEL TEXT
          Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppDarkColors.textColors2,
            ),
          ),
        ],
      ),
    );
  }
}

/// Vertical Divider for tab bar
class TabDivider extends StatelessWidget {
  const TabDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 1.5.w,
      color: AppDarkColors.textColors2.withOpacity(0.4),
      margin: EdgeInsets.symmetric(horizontal: 6.w),
    );
  }
}
