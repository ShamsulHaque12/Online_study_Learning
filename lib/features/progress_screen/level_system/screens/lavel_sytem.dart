import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/app_icons.dart';
import '../controller/lavel_system_controller.dart';
import '../custom_widget/lavel_tier_card.dart';

class LavelSytem extends StatelessWidget {
  LavelSytem({super.key});
  final LavelSystemController controller = Get.put(LavelSystemController());

  final List<String> titles = [
    "LEVEL 1",
    "LEVEL 2",
    "LEVEL 3",
    "LEVEL 4",
    "LEVEL 5",
  ];

  final List<String> subtitles = [
    "'Simula' (Foundations)",
    "'Gawi Araw-Araw' (Daily Life)",
    "'Pakikisalamuha' (Social Interaction)",
    "'Unang Hakbang' (First Steps)",
    "'Dalubhasa' (Mastery & Culture)",
  ];

  final List<String> descriptions = [
    "Getting comfortable with Tagalog basics — greetings...",
    "Routines, verbs (UM/MAG/IN), objects, sentences...",
    "Conversations, requests, emotions, politeness...",
    "Designed for speech, listening, real communication...",
    "Deep fluency, idioms, culture, expression...",
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

    return LavelTierCard(
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
