
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/components/custom_button.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/ai_screens/ai_writting/controller/ai_writting_controller.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class AiWrittingScreen extends StatelessWidget {
  AiWrittingScreen({super.key});
  final AiWrittingController controller = Get.put(AiWrittingController());
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
            langController.selectedLanguage["Writing Practice"] ?? "Writing Practice",
            style: GoogleFonts.inter(
              color: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                langController.selectedLanguage["Practice your writing skills with AI-generated prompts. Get instant feedback and suggestions to improve your writing style and grammar."] ?? "Practice your writing skills with AI-generated prompts. Get instant feedback and suggestions to improve your writing style and grammar.",

                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: isDark
                      ? AppDarkColors.primaryTextColor
                      : AppLightColors.primaryTextColor,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                langController.selectedLanguage["Your Prompt:"] ?? "Your Prompt:",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: isDark
                      ? AppDarkColors.primaryTextColor
                      : AppLightColors.primaryTextColor,
                ),
              ),
              SizedBox(height: 10.h),
              Obx(
                () => controller.promtLoading.value
                    ? SpinKitCircle(
                        color: isDark
                            ? AppDarkColors.primaryColor
                            : AppLightColors.primaryColor,
                      )
                    : Text(
                        controller.promt.value,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: isDark
                              ? AppDarkColors.primaryTextColor
                              : AppLightColors.primaryTextColor,
                        ),
                      ),
              ),
              SizedBox(height: 15.h),
              Text(
                langController.selectedLanguage["Your Response:"] ?? "Your Response:",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: isDark
                      ? AppDarkColors.primaryTextColor
                      : AppLightColors.primaryTextColor,
                ),
              ),
              SizedBox(height: 12.h),
              TextFormField(
                controller: controller.promtController,
                decoration: InputDecoration(hintText: "Enter your prompt here"),
                maxLines: 4,
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
              ),
              SizedBox(height: 20.h),
              Obx(
                () => CustomButton(
                  text: controller.isLoading.value
                      ? 'Evaluating...'
                      : 'Submit for Evaluation',
                  onPressed: controller.isLoading.value
                      ? null
                      : () {
                          controller.promptData();
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
