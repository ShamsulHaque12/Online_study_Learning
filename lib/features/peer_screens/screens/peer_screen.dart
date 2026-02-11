
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/home/controller/lesson_controller.dart';
import 'package:online_study/features/peer_screens/controller/peer_screen_controller.dart';
import 'package:online_study/global/widgets/custom_appbar.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class PeerScreen extends StatelessWidget {
  PeerScreen({super.key});

  final PeerScreenController controller = Get.put(PeerScreenController());
  final LessonController lessonController = Get.put(LessonController());

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(() {
      final isDarkMode = themeController.isDark.value;

    return Scaffold(
      backgroundColor: isDarkMode
          ? AppDarkColors.backgroundColor
          : AppLightColors.backgroundColor,
      appBar: CustomAppBar(
        fireCount: lessonController.user.value?.streak ?? 0,
        notoCount: lessonController.user.value?.totalPoint ?? 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔥 TAB BAR
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(color: Colors.orange, width: 2),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double tabWidth = (constraints.maxWidth - 20) / 3;

                  return Obx(
                    () => Row(
                      children: [
                        buildTab("Follower", 0, tabWidth),
                        const SizedBox(width: 10),
                        buildTab("Following", 1, tabWidth),
                        const SizedBox(width: 10),
                        buildTab("Find friend", 2, tabWidth),
                      ],
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 15.h),

            /// 🔥 TAB CONTENT
            Expanded(
              child: Obx(
                () => controller.screens[controller.selectedIndex.value],
              ),
            ),
          ],
        ),
      ),
    );
    });
  }

  /// 🔥 TAB BUTTON
  Widget buildTab(String title, int index, double width) {
    final bool isActive = controller.selectedIndex.value == index;

    return GestureDetector(
      onTap: () => controller.selectedIndex.value = index,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: width,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? AppDarkColors.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}
