
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/achivement/controller/achivement_controller.dart';
import 'package:online_study/features/badges_tiers/badges_widgets/tier_card.dart';

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
            onTap: () {},
          );
        },
      );
    });
  }
}
