import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_colours.dart';
class FeatureCard extends StatefulWidget {
  final bool isDark;
  final String icon;
  final String title;
  final String subtitle;
  final String level;
  final String duration;
  final String xp;
  final Widget? navigateTo;

  const FeatureCard({
    super.key,
    required this.isDark,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.level,
    required this.duration,
    required this.xp,
    this.navigateTo,
  });

  @override
  State<FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<FeatureCard> {
  bool isPressed = false;

  Color getLevelBg(String level) {
    switch (level.toLowerCase()) {
      case "beginner":
        return const Color(0xFFDCFEE8);
      case "intermediate":
        return const Color(0xFFFFEDD4);
      case "advanced":
        return const Color(0xFFFFE2E2);
      default:
        return Colors.grey.shade200;
    }
  }

  Color getLevelTextColor(String level) {
    switch (level.toLowerCase()) {
      case "beginner":
        return const Color(0xFF37B24D);
      case "intermediate":
        return const Color(0xFFE46A28);
      case "advanced":
        return const Color(0xFFE7000B);
      default:
        return Colors.black87;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) {
        setState(() => isPressed = false);
        if (widget.navigateTo != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => widget.navigateTo!),
          );
        }
      },
      onTapCancel: () => setState(() => isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: double.infinity,
        height: 210.h,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: widget.isDark
              ? AppColors.containerdark
              : AppColors.containerBG,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isPressed ? Colors.green : Colors.transparent,
            width: 3.w,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: buildContent(),
      ),
    );
  }

  Widget buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: AppColors.btnBG,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: SvgPicture.asset(widget.icon, height: 30.h),
        ),

        SizedBox(height: 8.h),

        // Title
        Text(
          widget.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: widget.isDark
                ? AppColors.containerBG
                : AppColors.lightText,
          ),
        ),

        SizedBox(height: 4.h),

        // Subtitle
        Expanded(
          child: Text(
            widget.subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: widget.isDark
                  ? AppColors.containerBG
                  : AppColors.lightText,
            ),
          ),
        ),

        SizedBox(height: 8.h),

        // LEVEL + TIME (Fixed Overflow)
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: getLevelBg(widget.level),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                widget.level,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: getLevelTextColor(widget.level),
                ),
              ),
            ),

            SizedBox(width: 8.w),

            /// 🔥 FIXED OVERFLOW — duration text now shrinks instead of overflowing
            Expanded(
              child: Text(
                widget.duration,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: widget.isDark
                      ? AppColors.containerBG
                      : AppColors.lightText,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 5.h),

        // XP
        Row(
          children: [
            Text(
              "•",
              style: TextStyle(
                fontSize: 22.sp,
                color: const Color(0xFF1FB8B7),
              ),
            ),
            SizedBox(width: 6.w),
            Text(
              widget.xp,
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF1FB8B7),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
