
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_study/survey_screen/screens/servey_learn_language.dart';

import '../../component/custom_widgets/custom_button.dart';
import '../../component/custom_widgets/custom_text_field.dart';
import '../../core/app_colours.dart';
import '../../core/app_images.dart';
import '../controller/servey_controller.dart';

class SurveyName extends StatelessWidget {
  final ServeyController controller = Get.put(ServeyController());
  SurveyName({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Profile + Text Row
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 40.r,
                          backgroundColor: Colors.grey[400],
                          backgroundImage: AssetImage(AppImages.putul),
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
                    CustomTextField(
                      textEditingController: controller.nameController,
                      hintText: "Enter your name",
                      hintTextColor: isDark ? Colors.grey : Colors.grey,
                      fillColor: Colors.transparent,
                      textColor: isDark ? Colors.white : Colors.black,
                      borderSide: BorderSide(
                        color: isDark ? Colors.white : Colors.black,
                        width: 1.w,
                      ),
                    ),


                    /// Continue Button

                  ],
                ),
              ),
            ),
          ),
          CustomButton(
            text: "Continue",
            onTap: () {
              Get.to(() => ServeyLearnLanguage());
            },
            backgroundColor: AppColors.btnBG,
            textColor: Colors.white,
            borderColor: Colors.transparent,
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
