import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../component/custom_widgets/custom_button.dart';
import '../../../../core/app_colours.dart';
import '../controller/vocabulary_controller.dart';

class VocabularyScreen extends StatelessWidget {
  VocabularyScreen({super.key});
  final VocabularyController controller = Get.put(VocabularyController());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          "Vocabulary",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: GetBuilder<VocabularyController>(
          builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tap the matching Word",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),

                SizedBox(height: 20.h),

                /// ----------------------------
                ///    TWO COLUMN MATCH GRID
                /// ----------------------------
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// LEFT SIDE → ENGLISH
                    Expanded(
                      child: Column(
                        children: controller.englishWords.map((item) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: GestureDetector(
                              onTap: () => controller.selectEnglish(item),
                              child: Container(
                                height: 70.h,
                                padding: EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: item.bgColor,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Color(0xFFCED4DA),
                                    width: 1.w,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    item.text,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: isDark
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    SizedBox(width: 12),

                    /// RIGHT SIDE → FILIPINO
                    Expanded(
                      child: Column(
                        children: controller.filipinoWords.map((item) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: GestureDetector(
                              onTap: () => controller.selectFilipino(item),
                              child: Container(
                                height: 70.h,
                                padding: EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: item.bgColor,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Color(0xFFCED4DA),
                                    width: 1.w,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    item.text,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: isDark
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30.h),

                /// CHECK BUTTON
                CustomButton(
                  text: "Check",
                  onTap: () => controller.checkMatch(),
                  backgroundColor: AppColors.center,
                  textColor: AppColors.lightText,
                  radius: 12.r,
                  borderColor: Colors.transparent,
                ),

                SizedBox(height: 20.h),
              ],
            );
          },
        ),
      ),
    );
  }
}
