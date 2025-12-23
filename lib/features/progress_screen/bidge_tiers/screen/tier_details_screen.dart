import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/features/progress_screen/bidge_tiers/screen/tier2_details_screen.dart';
import '../../../../core/app_colours.dart';
import '../../../../core/app_icons.dart';
import '../controller/tier_details_controller.dart';
import '../bedge_widget/tier_details_card.dart';

class TierDetailsScreen extends StatelessWidget {
  final String tittle;
  TierDetailsScreen({super.key, required this.tittle});

  final TierDetailsController controller = Get.put(TierDetailsController());

  /// Only titles (7 tiers)
  final List<String> titles = [
    "Beginner Tier",
    "Consistent Tier",
    "Grammar & Vocabulary Tier",
    "Conversation & Pronunciation Tier",
    "Master & Progression Tier",
    "Fun, Secret, & Easter Egg Tier",
    "Ultimate Tier",
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          tittle,
          style: GoogleFonts.nunito(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.bgLight : AppColors.lightText,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Obx(() {
          List<Widget> rows = [];

          for (int i = 0; i < titles.length; i += 2) {
            // 2 per row
            List<Widget> rowChildren = [];
            rowChildren.add(Expanded(child: _buildTier(i)));

            if (i + 1 < titles.length) {
              rowChildren.add(SizedBox(width: 10.w));
              rowChildren.add(Expanded(child: _buildTier(i + 1)));
            }

            rows.add(Row(children: rowChildren));
            rows.add(SizedBox(height: 10.h));
          }

          return Column(children: rows);
        }),
      ),
    );
  }

  Widget _buildTier(int index) {
    bool unlocked = controller.isUnlocked(index);

    return TierDetailsCard(
      isUnlocked: unlocked,
      title: titles[index],
      iconUnlocked: AppIcons.bronze,
      iconLocked: AppIcons.lockBronze,
      onTap: () {
        if (unlocked) {
          print("Entering Tier ${index + 1}");
          Get.to(() => Tier2DetailsScreen(tittle: titles[index]));
        } else {
          print("Tier ${index + 1} is locked.");
        }
      },
    );
  }
}
