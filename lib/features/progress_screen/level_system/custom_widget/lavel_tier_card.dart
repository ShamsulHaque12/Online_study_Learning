import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/app_colours.dart';

class LavelTierCard extends StatelessWidget {
  final bool isUnlocked;
  final String title;
  final String subtitle;
  final String description;
  final String iconUnlocked;
  final String iconLocked;
  final VoidCallback onTap;

  const LavelTierCard({
    super.key,
    required this.isUnlocked,
    required this.title,
    required this.subtitle,
    required this.description,
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
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.transparent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
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
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              subtitle,
              style: GoogleFonts.nunito(
                fontSize: 14.sp,
                fontWeight: FontWeight.w300,
                color: AppColors.grammer,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.h),
            Text(
              description,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w300,
                overflow: TextOverflow.ellipsis,
                color: isDark ? AppColors.bgLight : AppColors.lightText,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
