
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/achivement/controller/achivement_controller.dart';
import 'package:online_study/features/badges_tiers/badges_widgets/tier_card.dart';

class MetaBadgesScreen extends StatelessWidget {
  MetaBadgesScreen({super.key});
  final AchivementController controller = Get.find<AchivementController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.badgeTiersList.isEmpty) {
        return Center(child: SpinKitCircle(color: AppDarkColors.primaryColor));
      }

      return GridView.builder(
        padding: EdgeInsets.all(10.w),
        shrinkWrap: false, // let GridView take all space
        physics: const AlwaysScrollableScrollPhysics(), // allow scrolling
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15.h,
          crossAxisSpacing: 10.w,
          childAspectRatio: 0.8,
        ),
        itemCount: controller.metaBadgesList.length,
        itemBuilder: (context, index) {
          final badge = controller.metaBadgesList[index];
          return TierCard(
            isUnlocked: badge.unlocked ?? false,
            title: badge.title ?? "",
            subtitle: badge.ltDesc ?? "",
            description: badge.enDesc ?? "",
            iconUnlocked: 'assets/images/unlock.png',
            iconLocked: 'assets/images/locks.png',
            onTap: () {},
          );
        },
      );
    });
  }
}
