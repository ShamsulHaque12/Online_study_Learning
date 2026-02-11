
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/components/custom_button.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_images.dart';
import 'package:online_study/features/ai_screens/ai_flash_card/controller/ai_flash_card_controller.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class AiFlashCard extends StatelessWidget {
  AiFlashCard({super.key});
  final AiFlashCardController aiFlashCardController = Get.put(
    AiFlashCardController(),
  );
  final langController = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(() {
    final isDark = themeController.isDark.value;
      return Scaffold(
        backgroundColor: isDark
            ? AppDarkColors.backgroundColor
            : AppLightColors.backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: isDark
              ? AppDarkColors.backgroundColor
              : AppLightColors.backgroundColor,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          title: Text(
            langController.selectedLanguage["FlashCard"] ?? "FlashCard",
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    langController.selectedLanguage["Saving Words"] ?? "Saving Words",
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppDarkColors.primaryTextColor
                          : AppLightColors.primaryTextColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Center(
                child: Image.asset(
                  AppImages.pencilPutul,
                  height: 200.h,
                  width: 200.w,
                ),
              ),
              SizedBox(height: 15.h),
              Center(
                child: Text(
                  langController.selectedLanguage["Start Your Learning Journey"] ?? "Start Your Learning Journey",
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppDarkColors.tealColor,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Center(
                child: Text(
                  langController.selectedLanguage["Search for any word to see its meaning, pronunciation,and examples."] ?? "Search for any word to see its meaning, pronunciation,and examples.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: isDark
                        ? AppDarkColors.primaryTextColor
                        : AppLightColors.primaryTextColor,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Obx(
                () => aiFlashCardController.flashCardGenerateLoading.value
                    ? SpinKitCircle(
                        color: isDark
                            ? AppDarkColors.primaryColor
                            : AppLightColors.primaryColor,
                      )
                    : CustomButton(
                        text: "Continue",
                        onPressed: () {
                          //Get.to(() => FlipCardScreen());
                          aiFlashCardController.fetchFlashCards();
                        },
                      ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
