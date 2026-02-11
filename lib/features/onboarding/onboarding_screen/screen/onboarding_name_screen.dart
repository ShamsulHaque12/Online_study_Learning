
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_study/components/custom_button.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_images.dart';
import 'package:online_study/features/onboarding/onboarding_screen/controller/onbording_controller.dart';
import 'package:online_study/features/onboarding/onboarding_screen/screen/learn_language.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class OnboardingNameScreen extends StatefulWidget {
  const OnboardingNameScreen({super.key});

  @override
  State<OnboardingNameScreen> createState() => _OnboardingNameScreenState();
}

class _OnboardingNameScreenState extends State<OnboardingNameScreen> {
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final onBoardingController = Get.put(OnbordingController());
    final formKey = GlobalKey<FormState>();


    return Obx(() {
    final isDark = themeController.isDark.value;
      return Scaffold(
      backgroundColor: isDark
          ? AppDarkColors.backgroundColor
          : AppLightColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: isDark
            ? AppDarkColors.backgroundColor
            : AppLightColors.backgroundColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),

                        /// Profile + Text Row
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[400],
                              ),
                              child: Image.asset(
                                AppImages.pencilPutul,
                                width: 100.w,
                                height: 100.h,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(
                                "We can call you as...",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),

                        /// Name Input
                        TextFormField(
                          controller: onBoardingController.nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Enter your name",
                          ),
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),

                /// Continue Button fixed at bottom
                CustomButton(
                  text: "Continue",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // If the form is valid, proceed to the next screen
                      Get.to(() => LearnLanguage());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
    });
  }
}
