import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:online_study/features/home_screen/challenge_screen/screen/vocabulary_screen.dart';
import '../../../../core/app_colours.dart';
import 'choose_word_screen.dart';
import 'listen_image_screen.dart';

class ChallengeScreen extends StatelessWidget {
  final String lessonTitle;
  const ChallengeScreen({super.key, required this.lessonTitle});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final double cardWidth = MediaQuery.of(context).size.width * 0.44;

    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          lessonTitle,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Center(
              child: Divider(
                thickness: 3,
                color: AppColors.btnBG,
              ),
            ),
            Center(
              child: Text(
                "Choose Game",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.btnBG,
                ),
              ),
            ),
            SizedBox(height: 15.h),

            /// ------------ 2 Cards Per Row -----------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LearningCategoryCard(
                  width: cardWidth,
                  title: "Vocabulary",
                  iconPath: "assets/icons/boi.svg",
                  onTap: () {
                    Get.to(()=>VocabularyScreen());
                  },
                ),
                LearningCategoryCard(
                  width: cardWidth,
                  title: "Choose Word",
                  iconPath: "assets/icons/hand.svg",
                  onTap: () {
                    Get.to(()=>ChooseWordScreen());
                  },
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LearningCategoryCard(
                  width: cardWidth,
                  title: "Listen & Choose",
                  iconPath: "assets/icons/headphone.svg",
                  onTap: () {
                    Get.to(()=>ListenImageScreen());
                  },
                ),
                LearningCategoryCard(
                  width: cardWidth,
                  title: "Find Image",
                  iconPath: "assets/icons/image.svg",
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LearningCategoryCard(
                  width: cardWidth,
                  title: "Write Word",
                  iconPath: "assets/icons/writting.svg",
                  onTap: () {},
                ),
                LearningCategoryCard(
                  width: cardWidth,
                  title: "Listen& Write",
                  iconPath: "assets/icons/edit_text.svg",
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LearningCategoryCard(
                  width: cardWidth,
                  title: "Mixed Game",
                  iconPath: "assets/icons/mixd.svg",
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class LearningCategoryCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final double width;
  final VoidCallback? onTap;

  const LearningCategoryCard({
    super.key,
    required this.title,
    required this.iconPath,
    required this.width,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 120.h,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.btnBG,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.center,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                iconPath,
                height: 22.h,
                width: 22.w,
              ),
            ),
            SizedBox(height: 5.h),
            Divider(
              thickness: 2,
              color: AppColors.borderLine,
            ),
            SizedBox(height: 5.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.btnwhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
