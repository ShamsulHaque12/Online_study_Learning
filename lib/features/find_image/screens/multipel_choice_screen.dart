
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/find_image/controller/image_controller.dart';
import 'package:online_study/features/find_image/model/image_options.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class MultipleChoiceScreen extends StatelessWidget {
  MultipleChoiceScreen({super.key});

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
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (question.description != null)
                    Text(
                      question.description!,
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        color: isDark
                            ? AppDarkColors.primaryTextColor
                            : AppLightColors.primaryTextColor,
                      ),
                    ),
                  SizedBox(height: 20.h),
                  _buildCharacterCard(question),
                  SizedBox(height: 20.h),
                  _buildOptionsList(question.options),
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

  Widget _buildCharacterCard(ImageQuestion question) {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.isDark.value;
    return Center(
      child: Column(
        children: [
          // Image display
          if (question.imageUrl != null)
            Image.network(
              question.imageUrl!,
              height: 200.h,
              width: double.infinity,
              fit: BoxFit.contain,
            )
          else
            const Center(child: Text('👤', style: TextStyle(fontSize: 100))),
          SizedBox(height: 18.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: isDark
                  ? AppDarkColors.backgroundColor
                  : AppLightColors.backgroundColor,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade300, width: 1.w),
            ),
            child: Text(
              question.question,
              style: GoogleFonts.inter(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: isDark
                    ? AppDarkColors.primaryTextColor
                    : AppLightColors.primaryTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionsList(List<ImageOptions> options) {
    return Column(children: options.map(_buildOptionButton).toList());
  }

  Widget _buildOptionButton(ImageOptions option) {
    final themeController = Get.find<ThemeController>();
    return Obx(() {
    final isDark = themeController.isDark.value;
      final isSelected = controller.selectedOption.value == option.id;
      final isAnswered = controller.isAnswered.value;

      Color backgroundColor = isDark
          ? AppDarkColors.backgroundColor
          : AppLightColors.backgroundColor;
      Color borderColor = isDark ? Colors.white : AppLightColors.borderColor;
      Color textColor = isDark
          ? AppDarkColors.primaryTextColor
          : AppLightColors.primaryTextColor;

      if (isAnswered) {
        if (option.isCorrect) {
          backgroundColor = Colors.green.shade50;
          borderColor = Colors.green;
          textColor = Colors.green.shade700;
        } else if (isSelected && !option.isCorrect) {
          backgroundColor = Colors.red.shade50;
          borderColor = Colors.red;
          textColor = Colors.red.shade700;
        }
      } else if (isSelected) {
        backgroundColor = Colors.green.shade50;
        borderColor = Colors.green;
      }

      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: InkWell(
          onTap: () => controller.handleOptionClick(option),
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: borderColor, width: 1.w),
            ),
            child: Text(
              option.text,
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
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

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: controller.handleContinue,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppDarkColors.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Continue',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: isDark
                    ? AppDarkColors.primaryTextColor
                    : AppLightColors.primaryTextColor,
              ),
            ),
          ),
        ),
      );
    });
  }
}
