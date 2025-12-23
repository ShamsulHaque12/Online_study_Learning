import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../core/app_icons.dart';
import '../controller/meta_badges_controller.dart';
import '../custom_widgets/meta_tier_card.dart';

class MetaBadges extends StatelessWidget {
  MetaBadges({super.key});
  final MetaBadgesController controller = Get.put(MetaBadgesController());
  final List<String> titles = [
    "All Rounder",
    "Consistent Champion",
    "Legacy Learner",
    "Tutor of Tomorrow",
    "Mini-Game Master V",
  ];

  final List<String> subtitles = [
    "Diamond badge",
    "Animated XP flame",
    "Golden mic",
    "Special role title",
    "Game controller badge",
  ];

  final List<String> descriptions = [
    "Earn 3 achievements in each level",
    "Keep a 60-day streak across levels",
    "Reach 10 hours of total speaking time",
    "Teach or test a friend in 3 topics",
    "Win all mini-games in every level",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() {
        return Column(
          children: [
            /// ROW 1
            Row(
              children: [
                Expanded(child: _buildTier(0)),
                SizedBox(width: 10),
                Expanded(child: _buildTier(1)),
              ],
            ),

            SizedBox(height: 10),

            /// ROW 2
            Row(
              children: [
                Expanded(child: _buildTier(2)),
                SizedBox(width: 10),
                Expanded(child: _buildTier(3)),
              ],
            ),

            SizedBox(height: 10),

            /// ROW 3 → ONLY ONE TIER (index 4)
            Row(
              children: [
                Expanded(child: _buildTier(4)),
                Expanded(child: SizedBox()), // keep spacing balanced
              ],
            ),

            SizedBox(height: 20),
          ],
        );
      }),
    );
  }
  /// Tier Card Builder
  Widget _buildTier(int index) {
    bool unlocked = controller.isUnlocked(index);

    return MetaTierCard(
      isUnlocked: unlocked,
      title: titles[index],
      subtitle: subtitles[index],
      description: descriptions[index],
      iconUnlocked: AppIcons.unlock,
      iconLocked: AppIcons.lock,
      onTap: () {
        if (unlocked) {
          // Get.to(() => TierDetailsScreen(
          //   tittle: titles[index],
          // ));
        }
      },
    );
  }
}
