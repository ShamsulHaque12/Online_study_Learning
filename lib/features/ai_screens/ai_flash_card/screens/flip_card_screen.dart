
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_icons.dart';
import 'package:online_study/features/ai_screens/ai_flash_card/controller/ai_flash_card_controller.dart';
import 'package:online_study/features/ai_screens/ai_flash_card/model/flash_card_model.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class FlipCardScreen extends StatelessWidget {
  const FlipCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final aiFlashController = Get.find<AiFlashCardController>();

    return Obx(() {
      final isDark = themeController.isDark.value;

      if (aiFlashController.flashCardList.isEmpty) {
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      final currentFlash =
          aiFlashController.flashCardList.first.flashcards[
              aiFlashController.currentFlashIndex.value];

      return Scaffold(
        backgroundColor:
            isDark ? AppDarkColors.backgroundColor : AppLightColors.backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor:
              isDark ? AppDarkColors.backgroundColor : AppLightColors.backgroundColor,
          leading: IconButton(
            onPressed: () {
              aiFlashController.stopSpeaking();
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlipCard(
                fill: Fill.fillBack,
                direction: FlipDirection.HORIZONTAL,
                front: _buildCardFront(currentFlash),
                back: _buildCardBack(currentFlash, aiFlashController),
              ),
              SizedBox(height: 20.h),
              IconButton(
                onPressed: () => aiFlashController.nextFlashCard(),
                icon: Icon(
                  Icons.arrow_forward,
                  size: 32.sp,
                  color: isDark ? Colors.white : Color(0xffE46A28),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildCardFront(Flashcards flashcard) {
    return Center(
      child: Container(
        height: 255.h,
        width: 270.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xffFFE2D2),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          flashcard.word ?? '',
          style: GoogleFonts.inter(
            fontSize: 32.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xffE46A28),
          ),
        ),
      ),
    );
  }

  Widget _buildCardBack(Flashcards flashcard, AiFlashCardController controller) {
    return Center(
      child: Container(
        height: 255.h,
        width: 270.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xffFFE2D2),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => controller.speakWord(),
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: controller.isSpeaking.value
                      ? Color(0xffE46A28).withOpacity(0.2)
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  AppIcons.voiceIcon,
                  color: controller.isSpeaking.value ? Color(0xffE46A28) : null,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              flashcard.word ?? '',
              style: GoogleFonts.inter(
                fontSize: 32.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xffE46A28),
              ),
            ),
            Text(
              flashcard.syllables ?? '',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xffE46A28),
              ),
            ),
            Text(
              flashcard.englishMeaning ?? '',
              style: GoogleFonts.inter(
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xffE46A28),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
