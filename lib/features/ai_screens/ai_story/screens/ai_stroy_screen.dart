
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/components/custom_button.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/ai_screens/ai_story/controller/ai_story_controller.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class AiStroyScreen extends StatelessWidget {
  AiStroyScreen({super.key});
  final AiStoryController controller = Get.put(AiStoryController());

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
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          title: Text(
            langController.selectedLanguage["Short Stories"] ?? "Short Stories",
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
              /// TOPIC + LANGUAGE SWITCH
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    langController.selectedLanguage["Story Topic"] ?? "Story Topic",
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppDarkColors.primaryTextColor
                          : AppLightColors.primaryTextColor,
                    ),
                  ),

                  // Row(
                  //   children: [
                  //     CustomButtonWidget(
                  //       height: 28.h,
                  //       width: MediaQuery.sizeOf(context).width * 0.20,
                  //       text: "ENG",
                  //       onTap: () {},
                  //       backgroundColor: AppDarkColors.tealColor,
                  //       borderColor: Colors.transparent,
                  //     ),

                  //     SizedBox(width: 6.w),

                  //     SvgPicture.asset(
                  //       AppIcons.exchange,
                  //       height: 22.h,
                  //       width: 22.w,
                  //     ),

                  //     SizedBox(width: 6.w),

                  //     CustomButtonWidget(
                  //       height: 28.h,
                  //       width: MediaQuery.sizeOf(context).width * 0.20,
                  //       text: "TAG",
                  //       onTap: () {},
                  //       backgroundColor: AppDarkColors.tealColor,
                  //       borderColor: Colors.transparent,
                  //     ),
                  //   ],
                  // ),
                ],
              ),

              SizedBox(height: 15.h),

              /// STORY INPUT FIELD
              TextFormField(
                controller: controller.storiesController,
                decoration: InputDecoration(hintText: "write your text"),
                style: TextStyle(
                  color: isDark
                      ? AppDarkColors.primaryTextColor
                      : AppLightColors.primaryTextColor,
                ),
              ),

              SizedBox(height: 20.h),

              /// SUBMIT BUTTON
              Obx(() {
                return controller.isLoading.value
                    ? SpinKitCircle(color: AppDarkColors.primaryColor)
                    : CustomButton(
                        text: "Generate Story",
                        onPressed: () {
                          controller.aiGenaretStory();
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
