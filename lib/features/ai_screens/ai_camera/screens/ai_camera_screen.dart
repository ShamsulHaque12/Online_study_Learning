
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/ai_screens/ai_camera/controller/ai_camera_controller.dart';
import 'package:online_study/features/ai_screens/ai_camera/widgets/my_bottom_sheet.dart';
import 'package:online_study/features/ai_screens/ai_dictionary/screens/saving_data.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class AiCameraScreen extends StatelessWidget {
  AiCameraScreen({super.key});

  final AiCameraController controller = Get.put(AiCameraController());
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
            langController.selectedLanguage["Camera"] ?? "Camera",
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Get.to(() => SavingData());
                },
                child: Row(
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
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              /// -------- Choose Image --------
              GestureDetector(
                onTap: () => controller.showImageSourceSheet(),
                child: Center(
                  child: Text(
                    langController.selectedLanguage["Choose Image"] ?? "Choose Image",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: AppLightColors.primaryColor,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              /// -------- Preview + Submit --------
              Obx(() {
                if (controller.capturedImage.value == null) {
                  return const SizedBox();
                }

                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.file(
                        controller.capturedImage.value!,
                        height: 250.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    SizedBox(height: 20.h),

                    Obx(
                      () => controller.isLoading.value
                          ? SpinKitCircle(color: AppLightColors.primaryColor)
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppLightColors.primaryColor,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                controller.sendImage();

                                Future.delayed(
                                  const Duration(milliseconds: 200),
                                  () {
                                    if (!Get.isBottomSheetOpen!) {
                                      Get.bottomSheet(
                                        MyBottomSheet(),
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                      );
                                    }
                                  },
                                );
                              },
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
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
