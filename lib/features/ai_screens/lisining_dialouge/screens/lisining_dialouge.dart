
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/components/custom_button.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/ai_screens/lisining_dialouge/controller/lisining_dialouge_controller.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class LisiningDialouge extends StatelessWidget {
  LisiningDialouge({super.key});
  final LisiningDialougeController controller = Get.put(
    LisiningDialougeController(),
  );
  final langController = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx((){
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
          langController.selectedLanguage["Dialogue Listenting"] ?? "Dialogue Listenting",
          style: GoogleFonts.inter(
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
              langController.selectedLanguage["Dialogue Topic"] ?? "Dialogue Topic",
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppDarkColors.primaryTextColor
                    : AppLightColors.primaryTextColor,
              ),
            ),

            SizedBox(height: 6.h),
            TextFormField(
              controller: controller.textController,
              decoration: InputDecoration(hintText: "Enter your text here"),
              maxLines: 3,
              style: TextStyle(color: isDark ? Colors.white : Colors.black),
            ),
            SizedBox(height: 6.h),
            SizedBox(height: 20.h),
            Obx(() {
              return controller.isLoading.value
                  ? SpinKitCircle(color: AppDarkColors.primaryColor)
                  : CustomButton(
                      text: "Generate Dialogue",
                      onPressed: () {
                        controller.aiDialougeListining();
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
