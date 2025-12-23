import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/app_colours.dart';

class TierDetailsCard extends StatelessWidget {
  final bool isUnlocked;
  final String title;
  final String iconUnlocked;
  final String iconLocked;
  final VoidCallback onTap;

  const TierDetailsCard({
    super.key,
    required this.isUnlocked,
    required this.title,
    required this.iconUnlocked,
    required this.iconLocked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        width: 130.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.transparent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              isUnlocked ? iconUnlocked : iconLocked,
              height: 50.h,
              width: 60.w,
            ),
            SizedBox(height: 5.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.bgLight : AppColors.lightText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
