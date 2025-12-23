import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../bidge_tiers/screen/badge_tiers.dart';
import '../../level_system/screens/lavel_sytem.dart';
import '../../meta_badges/screens/meta_badges.dart';
import '../../controller/progress_controller.dart';

class AchievementScreen extends StatelessWidget {
  AchievementScreen({super.key});

  final ProgressController controller = Get.put(ProgressController());

  final List<String> tabs = ["Badge Tiers", "Level System", "Meta Badges"];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        /// ---------- TAB BAR ----------
        Container(
          height: 40.h,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Obx(() => Row(
            children: List.generate(tabs.length, (index) {
              final isSelected = controller.selectedAchive.value == index;

              return Expanded(
                child: GestureDetector(
                  onTap: () => controller.changeAchive(index),
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? (isDark ? Colors.white : Colors.black)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected
                            ? (isDark ? Colors.black : Colors.white)
                            : (isDark ? Colors.white : Colors.black),
                        width: 1.w,

                      )
                    ),
                    child: Text(
                      tabs[index],
                      style: TextStyle(
                        color: isSelected
                            ? (isDark ? Colors.black : Colors.white)
                            : (isDark ? Colors.white : Colors.black),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            }),
          )),
        ),

        /// ---------- TAB CONTENT ----------
        Expanded(
          child: Obx(() {
            switch (controller.selectedAchive.value) {
              case 0:
                return BadgeTiers();
              case 1:
                return LavelSytem();
              case 2:
                return MetaBadges();
              default:
                return BadgeTiers();
            }
          }),
        ),
      ],
    );
  }

}
