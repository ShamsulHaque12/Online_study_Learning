
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_icons.dart';
import 'package:online_study/features/achivement/controller/achivement_controller.dart';
import 'package:online_study/features/achivement/widgets_screens/badges_tiers/badges_widgets/tier_card.dart';
import 'package:online_study/features/achivement/widgets_screens/badges_tiers/screens/tier_details_screen.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class LavelSystemScreen extends StatelessWidget {
  LavelSystemScreen({super.key});
  final AchivementController controller = Get.find<AchivementController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.badgeTiersList.isEmpty) {
        return Center(child: SpinKitCircle(color: AppDarkColors.primaryColor));
      }

      return GridView.builder(
        padding: EdgeInsets.all(10.w),
        shrinkWrap: false,
        physics: const AlwaysScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15.h,
          crossAxisSpacing: 10.w,
          childAspectRatio: 0.8,
        ),
        itemCount: controller.levelSystemList.length,
        itemBuilder: (context, index) {
          final level = controller.levelSystemList[index];
          return TierCard(
            isUnlocked: level.unlocked ?? false,
            title: level.title ?? "",
            subtitle: level.ltDesc ?? "",
            description: level.enDesc ?? "",
            iconUnlocked: 'assets/images/unlock.png',
            iconLocked: 'assets/images/locks.png',
            onTap: () {
              if (level.unlocked == true) {
                Get.to(() => TierDetailsScreen(tierName: level.title ?? ""));
              } else {
                _showLockedDialog();
              }
            },
          );
        },
      );
    });
  }
  void _showLockedDialog() {
    final themeController = Get.find<ThemeController>();
    final langController = Get.find<LanguageController>();
    final isDark = themeController.isDark.value;
    Get.dialog(
      AlertDialog(
        backgroundColor: isDark
            ? AppDarkColors.backgroundColor
            : AppLightColors.backgroundColor,
        title: SvgPicture.asset(AppIcons.lockBronze, height: 70.h, width: 70.w),
        content: Text(
          langController
                  .selectedLanguage['You need to complete all previous tiers to unlock this tier.'] ??
              'You need to complete all previous tiers to unlock this tier.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: isDark
                ? AppDarkColors.primaryTextColor
                : AppLightColors.primaryTextColor,
          ),
        ),
        actions: [TextButton(onPressed: Get.back, child: const Text('Close'))],
      ),
      barrierDismissible: true,
    );
  }
}
