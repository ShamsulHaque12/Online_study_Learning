import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/app_colours.dart';
import '../../../core/app_images.dart';
import '../controller/native_language_controller.dart';

class NativeLanguageScreen extends StatelessWidget {
  final NativeLanguageController controller = Get.put(
    NativeLanguageController(),
  );
  NativeLanguageScreen({super.key});

  final Map<String, String> languageFlags = {
    'English (British)': AppImages.uk,
    'Tagalog': AppImages.thagalok,
  };

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          "Native Language",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: languageFlags.keys.map((language) {
            return Column(
              children: [
                Obx(
                  () => _LanguageTile(
                    title: language,
                    flagAsset: languageFlags[language]!,
                    isSelected: controller.selectedLanguage.value == language,
                    onTap: () => controller.selectLanguage(language),
                  ),
                ),
                SizedBox(height: 15.h),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  final String title;
  final String flagAsset;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageTile({
    required this.title,
    required this.flagAsset,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected
                ? AppColors.btnBG
                : (isDark ? AppColors.bgLight : Colors.black12),
            width: 2.w,
          ),
        ),
        child: Row(
          children: [
            // Flag image
            Image.asset(
              flagAsset,
              width: 35.w,
              height: 24.h,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: isDark ? AppColors.bgLight : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // Selected indicator
            Container(
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.btnBG : Colors.grey.shade400,
                  width: 2,
                ),
                color: Colors.white,
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.btnBG,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
