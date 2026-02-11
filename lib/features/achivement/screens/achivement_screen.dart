
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:online_study/features/achivement/controller/achivement_controller.dart';
import 'package:online_study/features/achivement/widgets_screens/lavel_system/screen/lavel_system_screen.dart';
import 'package:online_study/features/achivement/widgets_screens/meta_badges/screens/meta_badges_screen.dart';
import 'package:online_study/features/achivement/widgets_screens/badges_tiers/screens/badge_tiers_screen.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class AchivementScreen extends StatelessWidget {
  AchivementScreen({super.key});
  final AchivementController controller = Get.put(AchivementController());
  final langController = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    /// Fetch data on init
    controller.fetchAchivementData();

    return Obx(() {
      final isDark = themeController.isDark.value;

      // Reactive tabs based on language
      final tabs = [
        langController.selectedLanguage['Badge Tiers'] ?? 'Badge Tiers',
        langController.selectedLanguage['Level System'] ?? 'Level System',
        langController.selectedLanguage['Meta Badges'] ?? 'Meta Badges',
      ];

      return Column(
        children: [
          /// ---------- TAB BAR ----------
          Container(
            height: 50.h,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Obx(
              () => Row(
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
                          ),
                        ),
                        child: Text(
                          tabs[index],
                          textAlign: TextAlign.center,
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
              ),
            ),
          ),

          /// ---------- TAB CONTENT ----------
          Expanded(
            child: Obx(() {
              switch (controller.selectedAchive.value) {
                case 0:
                  return BadgeTiersScreen();
                case 1:
                  return LavelSystemScreen();
                case 2:
                  return MetaBadgesScreen();
                default:
                  return BadgeTiersScreen();
              }
            }),
          ),
        ],
      );
    });
  }
}
