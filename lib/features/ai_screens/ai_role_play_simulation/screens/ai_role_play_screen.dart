
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/components/custom_button_widget.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/ai_screens/ai_role_play_simulation/controller/response_controller.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class AiRolePlayScreen extends StatelessWidget {
  AiRolePlayScreen({super.key});

  final ResponseController controller = Get.put(ResponseController());

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final langController = Get.find<LanguageController>();

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
            onPressed: Get.back,
            icon: Icon(
              Icons.arrow_back_ios,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ),

        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ================= Scenario + Question =================
              Obx(() {
                final data = controller.rolePlayResponse.value;

                if (data == null) {
                  return Center(
                    child: SpinKitCircle(color: AppLightColors.primaryColor),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      langController.selectedLanguage["Scenario"] ?? "Scenario",
                      style: GoogleFonts.inter(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppDarkColors.primaryTextColor
                            : AppLightColors.primaryTextColor,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      data.scenario ?? "",
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: isDark
                            ? AppDarkColors.primaryTextColor
                            : AppLightColors.primaryTextColor,
                      ),
                    ),

                    SizedBox(height: 16.h),

                    Text(
                      langController.selectedLanguage["Question"] ?? "Question",
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppDarkColors.primaryColor,
                      ),
                    ),

                    SizedBox(height: 12.h),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 22.r,
                          backgroundColor: AppLightColors.primaryColor,
                          child: const Icon(
                            Icons.question_answer,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: AppLightColors.primaryColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "EN: ${data.questionEnglish ?? ""}",
                                  style: GoogleFonts.inter(
                                    fontSize: 13.sp,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  "Local: ${data.questionInLanguage ?? ""}",
                                  style: GoogleFonts.inter(
                                    fontSize: 13.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),

              SizedBox(height: 24.h),

              /// ================= TEXT FIELD (Voice text shows here) =================
              TextField(
                controller: controller.textController,
                maxLines: 2,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: isDark ? Colors.white : Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: "Type or speak your response...",
                  filled: true,
                  fillColor: isDark ? Colors.grey[800] : Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              /// ================= MIC + SUBMIT =================
              Row(
                children: [
                  /// 🎤 MIC BUTTON
                  Obx(() {
                    return GestureDetector(
                      onTap: () {
                        controller.isListening.value
                            ? controller.stopVoiceRecording()
                            : controller.startVoiceRecording();
                      },
                      child: Container(
                        width: 50.w,
                        height: 50.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: controller.isListening.value
                              ? Colors.red
                              : AppLightColors.primaryColor,
                        ),
                        child: Icon(
                          controller.isListening.value ? Icons.stop : Icons.mic,
                          color: Colors.white,
                          size: 26.sp,
                        ),
                      ),
                    );
                  }),

                  SizedBox(width: 10.w),

                  /// 📤 SUBMIT BUTTON
                  Expanded(
                    child: Obx(
                      () => CustomButtonWidget(
                        backgroundColor: AppLightColors.primaryColor,
                        text: controller.isLoading.value
                            ? "waiting..."
                            : "Submit",
                        onTap: controller.currectResponse,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              /// ================= AI FEEDBACK =================
              Obx(() {
                final correction = controller.roleCorrection.value;
                if (correction == null) return const SizedBox();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      langController.selectedLanguage["AI Feedback"] ?? "AI Feedback",
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppDarkColors.primaryTextColor
                            : AppLightColors.primaryTextColor,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    Text(
                      langController.selectedLanguage["Your Response:"] ?? "Your Response:",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? AppDarkColors.primaryTextColor
                            : AppLightColors.primaryTextColor,
                      ),
                    ),
                    Text(correction.original ?? "",
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: isDark
                              ? AppDarkColors.primaryTextColor
                              : AppLightColors.primaryTextColor,
                    )),

                    SizedBox(height: 8.h),

                    Text(
                      langController.selectedLanguage["Better Response:"] ?? "Better Response:",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      correction.better ?? "",
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: isDark
                            ? AppDarkColors.primaryTextColor
                            : AppLightColors.primaryTextColor,
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      );
    });
  }
}
