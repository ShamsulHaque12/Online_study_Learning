
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/components/custom_button.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/ai_screens/ai_dialouge/controller/ai_dialouge_controller.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class AiDialougeScreen extends StatelessWidget {
  AiDialougeScreen({super.key});
  final AiDialougeController controller = Get.put(AiDialougeController());
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
            langController.selectedLanguage["Dialogue Builder"] ?? "Dialogue Builder",
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
              Text(
               langController.selectedLanguage[ "Dialogue Topic"] ?? "Dialogue Topic",
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? AppDarkColors.primaryTextColor
                      : AppLightColors.primaryTextColor,
                ),
              ),
              SizedBox(height: 12.h),
              TextFormField(
                controller: controller.dialougeController,
                maxLines: 4,
                decoration: InputDecoration(hintText: "write your text"),
                style: TextStyle(
                  color: isDark
                      ? AppDarkColors.primaryTextColor
                      : AppLightColors.primaryTextColor,
                ),
              ),
              SizedBox(height: 20.h),
              Obx(() {
                return controller.isLoading.value
                    ? SpinKitCircle(color: AppDarkColors.primaryColor)
                    : CustomButton(
                        text: "Generate Dialogue",
                        onPressed: () async {
                        await controller.aiGenaretDialouge();
                        },
                      );
              }),
            ],
          ),
        ),
      );
    });
  }
}
