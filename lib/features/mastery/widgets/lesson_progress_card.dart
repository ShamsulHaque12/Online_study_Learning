import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_study/features/mastery/model/mastery_model.dart';
import '../controller/mastery_controller.dart';

class LessonProgressCard extends StatelessWidget {
  final Section section;
  final MasteryController controller = Get.put(MasteryController());

  LessonProgressCard({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    final int progressValue = section.progressPercent ?? 0;
    final double progress = progressValue / 100;

    return Stack(
      children: [
        /// PROGRESS BAR
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: SizedBox(
            height: 50.h,
            width: double.infinity,
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFF4DB8BB),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFFD85A2E),
              ),
            ),
          ),
        ),

        /// LEFT ICON
        Positioned(
          left: 8,
          top: 0,
          bottom: 0,
          child: Center(
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.menu_book_rounded,
                color: Color(0xFF4DB8BB),
                size: 20,
              ),
            ),
          ),
        ),

        /// RIGHT VALUE (Progress %)
        Positioned(
          right: 12,
          top: 0,
          bottom: 0,
          child: Center(
            child: Text(
              '$progressValue%',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),

        /// BOTTOM TEXT (completed/total lessons)
        // Positioned(
        //   left: 52.w,
        //   bottom: 4.h,
        //   child: Text(
        //     "${section.completedLessons ?? 0}/${section.totalLessons ?? 0} Lessons Completed",
        //     style: TextStyle(
        //       fontSize: 12.sp,
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
