import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_colours.dart';

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
        color: isSelected ? const Color(0xffECF6FF) : Colors.transparent,
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
              SvgPicture.asset(icon, height: 16.h, width: 16.w),
              SizedBox(width: 5.w),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.grammer,
                ),
              ),
            ],
          ),

          SizedBox(height: 4.h),

          /// LABEL TEXT
          Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.grammer,
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
      color: AppColors.text2.withOpacity(0.4),
      margin: EdgeInsets.symmetric(horizontal: 6.w),
      alignment: Alignment.center,
    );
  }
}

