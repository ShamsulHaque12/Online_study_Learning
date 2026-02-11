
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/find_image/controller/image_controller.dart';
import 'package:online_study/features/find_image/model/image_options.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class TrueFalseScreen extends StatelessWidget {
  TrueFalseScreen({super.key});

  final ImageController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(() {
      final isDark = themeController.isDark.value;
    return Column(
      children: [
        Expanded(
          child: Obx(() {
            final question = controller.currentQuestionModel;
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Top icon / image
                  if (question.imageUrl != null)
                    Image.network(
                      question.imageUrl!,
                      height: 200.h,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    )
                  else
                    Center(child: Text('📖', style: TextStyle(fontSize: 100))),

                  SizedBox(height: 20.h),
                  // Question text
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppDarkColors.backgroundColor
                          : AppLightColors.backgroundColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark
                            ? Colors.white
                            : AppLightColors.borderColor,
                        width: 1.w,
                      ),
                    ),
                    child: Text(
                      question.question,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? AppDarkColors.primaryTextColor
                            : AppLightColors.primaryTextColor,
                        height: 1.5,
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                  _buildTrueFalseButtons(question.options),
                ],
              ),
            );
          }),
        ),
        _buildBottomSection(),
        SizedBox(height: 40.h),
      ],
    );
    });
  }

  Widget _buildTrueFalseButtons(List<ImageOptions> options) {
    return Row(
      children: [
        Expanded(
          child: _buildButton(
            options.firstWhere((opt) => opt.text == "False"),
            Colors.red,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildButton(
            options.firstWhere((opt) => opt.text == "True"),
            Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildButton(ImageOptions option, MaterialColor baseColor) {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.isDark.value;
    return Obx(() {
      final isSelected = controller.selectedOption.value == option.id;
      final isAnswered = controller.isAnswered.value;

      // Default colors
      Color backgroundColor = isDark
          ? AppDarkColors.backgroundColor
          : AppLightColors.backgroundColor;
      Color borderColor = isDark ? Colors.white : AppLightColors.borderColor;
      Color textColor = baseColor[700]!;

      // Answered logic
      if (isAnswered) {
        if (option.isCorrect) {
          backgroundColor = Colors.green[100]!;
          borderColor = Colors.green;
          textColor = Colors.green[700]!;
        } else if (isSelected && !option.isCorrect) {
          backgroundColor = Colors.red[100]!;
          borderColor = Colors.red;
          textColor = Colors.red[700]!;
        } else {
          backgroundColor = Colors.grey[100]!;
          borderColor = Colors.grey[300]!;
          textColor = Colors.grey[600]!;
        }
      } else if (isSelected) {
        backgroundColor = baseColor[100]!;
        borderColor = baseColor;
      }

      return InkWell(
        onTap: () => controller.handleOptionClick(option),
        borderRadius: BorderRadius.circular(50.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: borderColor, width: 1.w),
          ),
          child: Text(
            option.text,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      );
    });
  }

  Widget _buildBottomSection() {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.isDark.value;
    return Obx(() {
      if (!controller.isAnswered.value) return const SizedBox.shrink();
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark
              ? AppDarkColors.backgroundColor
              : AppLightColors.backgroundColor,
        ),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: controller.handleContinue,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppDarkColors.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Continue',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    });
  }
}
