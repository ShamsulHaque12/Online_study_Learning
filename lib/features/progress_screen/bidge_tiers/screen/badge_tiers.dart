import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_study/features/progress_screen/bidge_tiers/screen/tier_details_screen.dart';
import '../../../../core/app_icons.dart';
import '../controller/badge_tiers_controller.dart';
import '../bedge_widget/tier_card.dart';

class BadgeTiers extends StatelessWidget {
  BadgeTiers({super.key});

  final BadgeTiersController controller = Get.put(BadgeTiersController());

  /// ✅ Custom text per tier
  final List<String> titles = [
    "Beginner Tier",
    "Consistent Tier",
    "Grammar & Vocabulary Tier",
    "Conversation & Pronunciation Tier",
    "Maste & Pro ression Tier",
    "Fun, Secret, & Easter Egg Tier",
  ];

  final List<String> subtitles = [
    "'Unang Hakbang' (First Steps)",
    "'Araw-Araw' (Daily Dedication)",
    "Talino Mode",
    "'Unang Hakbang' (First Steps)",
    "Daiubhasa' (Expert Level)",
    "Lihim na Parangal",
  ];

  final List<String> descriptions = [
    "Celebrate your first steps into Tagalog!",
    "Reward discipline and habit-building.",
    "For the learners mastering the structure of Tagalog.",
    "Designed for speech, listening, and real communication.",
    "Recognize elite learners who complete major milestones.",
    "Hidden gems that add humor and delight.",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() {
        return Column(
          children: [
            /// ----------- ROW 1 (Tier 1 & Tier 2) -------------
            Row(
              children: [
                Expanded(child: _buildTier(0)),
                SizedBox(width: 10),
                Expanded(child: _buildTier(1)),
              ],
            ),

            SizedBox(height: 10.h),

            /// ----------- ROW 2 (Tier 3 & Tier 4) -------------
            Row(
              children: [
                Expanded(child: _buildTier(2)),
                SizedBox(width: 10),
                Expanded(child: _buildTier(3)),
              ],
            ),

            SizedBox(height: 10.h),

            /// ----------- ROW 3 (Tier 5 & Tier 6) -------------
            Row(
              children: [
                Expanded(child: _buildTier(4)),
                SizedBox(width: 10),
                Expanded(child: _buildTier(5)),
              ],
            ),

            SizedBox(height: 20),
          ],
        );
      }),
    );
  }

  /// 🔥 Reusable Method for Creating TierCard
  Widget _buildTier(int index) {
    bool unlocked = controller.isUnlocked(index);

    return TierCard(
      isUnlocked: unlocked,
      title: titles[index],
      subtitle: subtitles[index],
      description: descriptions[index],
      iconUnlocked: AppIcons.unlock,
      iconLocked: AppIcons.lock,

      onTap: () {
        if (unlocked) {
          print("Entering Tier ${index + 1}");
          Get.to(() => TierDetailsScreen(
            tittle: titles[index],
          ));
        } else {
          print("Tier ${index + 1} is locked.");
        }
      },
    );
  }
}

