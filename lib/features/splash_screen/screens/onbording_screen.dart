import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../auth/acount_screen/account_screen_view.dart';
import '../../../component/custom_widgets/bg_widget.dart';
import '../../../component/custom_widgets/custom_button.dart';
import '../../../core/app_colours.dart';
import '../../../survey_screen/screens/survey_first.dart';
import '../../../theme/app_theme/theme_controller.dart';

class OnbordingScreen extends StatelessWidget {
  const OnbordingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(height: 200.h),

                // Center(
                //   child: Image.asset(
                //     "assets/images/pakhi.png",
                //     width: 200.w,
                //     height: 200.h,
                //   ),
                // ),

                SizedBox(height: 20.h),

                // System Mode Switch
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       "Use System Theme",
                //       style: TextStyle(
                //         color: isDark ? Colors.white : Colors.black,
                //         fontSize: 15,
                //       ),
                //     ),
                //
                //     Obx(() => CupertinoSwitch(
                //       activeColor: Colors.blue,
                //       value: themeController.themeMode.value == ThemeMode.system,
                //       onChanged: (value) {
                //         if (value) {
                //           themeController.changeTheme(ThemeMode.system);
                //         }
                //       },
                //     )),
                //   ],
                // ),

                SizedBox(height: 15),

                // Dark Mode Switch
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Dark Mode",
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 15,
                      ),
                    ),

                    Obx(() => CupertinoSwitch(
                      activeColor: Colors.blue,
                      value: themeController.themeMode.value == ThemeMode.dark,
                      onChanged: (value) {
                        if (value) {
                          themeController.changeTheme(ThemeMode.dark);
                        } else {
                          themeController.changeTheme(ThemeMode.light);
                        }
                      },
                    )),
                  ],
                ),

                SizedBox(height: 25),

                // Get Start Button
                CustomButton(
                  text: "Get Start",
                  onTap: () {
                    Get.to(()=>SurveyFirst());
                  },
                  backgroundColor: AppColors.btnBG,
                  textColor: Colors.white,
                  borderColor: Colors.transparent,
                ),

                SizedBox(height: 20.h),

                // Already Account Button
                CustomButton(
                  text: "I already have an account",
                  textColor: isDark ? Color(0xFF9DEBEA) : Colors.blue,
                  onTap: () {
                     Get.to(()=>AccountScreenView());
                  },
                  backgroundColor: isDark ? Colors.black45 : Color(0xFFF8F9FA),
                  borderColor: Colors.transparent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
