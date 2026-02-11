
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/ai_screens/ai_dialouge/controller/ai_dialouge_controller.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class DialugeBuilderScreen extends StatelessWidget {
  DialugeBuilderScreen({super.key});

  final AiDialougeController controller = Get.find<AiDialougeController>();
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
           langController.selectedLanguage[ "Dialogue Builder"] ?? "Dialogue Builder",
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        /// 🔥 BODY
        body: Obx(() {
          /// ---------- Loading ----------
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          /// ---------- No Data ----------
          if (controller.dialogue.value == null) {
            return Center(child: Text(langController.selectedLanguage["No dialogue generated"] ?? "No dialogue generated"));
          }

          final question = controller.currentQuestion;
          final selectedIndex = controller.currentStepAnswer.value;
          final selectedOption = selectedIndex != null
              ? question.options[selectedIndex]
              : null;

          return Column(
            children: [
              /// ---------- Progress ----------
              Padding(
                padding: const EdgeInsets.all(10),
                child: LinearProgressIndicator(
                  value: controller.progress,
                  backgroundColor: Colors.grey[300],
                  color: AppDarkColors.primaryColor,
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),

              Text(
                'Step ${controller.currentStep.value} of ${controller.totalSteps}',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? AppDarkColors.primaryTextColor
                      : AppLightColors.primaryTextColor,
                ),
              ),

              /// ---------- Dialogue ----------
              Expanded(
                child: Column(
                  children: [
                    SizedBox(height: 14.sp),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// AI Message
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.yellow,
                                radius: 25.r,
                                child: const Icon(Icons.person),
                              ),
                              const SizedBox(width: 12),
                              Flexible(
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: AppDarkColors.primaryColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "ENG: ${question.english}",
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        "S.Lang: ${question.tagalog}",
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          /// User Answer
                          if (selectedOption != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "ENG: ${selectedOption.english}",
                                            style: GoogleFonts.inter(
                                              color: Colors.white,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                          Text(
                                            "S.Lang: ${selectedOption.tagalog}",
                                            style: GoogleFonts.inter(
                                              color: Colors.white,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  CircleAvatar(
                                    backgroundColor: Colors.blue[100],
                                    radius: 25.r,
                                    child: const Icon(Icons.person),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    /// ---------- Buttons ----------
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: controller.openBottomSheet,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFA97E),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                              child: Text(
                                langController.selectedLanguage['Choose Answer'] ?? 'Choose Answer',
                                style: GoogleFonts.inter(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          ElevatedButton(
                            onPressed: controller.canSend
                                ? controller.sendAnswer
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: controller.sendButtonColor,
                              disabledBackgroundColor: Colors.grey[300],
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 12,
                              ),
                            ),
                            child: Text(
                              langController.selectedLanguage['Send'] ?? 'Send',
                              style: GoogleFonts.inter(
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 12.h),
                  ],
                ),
              ),
            ],
          );
        }),
      );
    });
  }
}
