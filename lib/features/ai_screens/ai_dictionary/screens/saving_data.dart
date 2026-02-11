
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/ai_screens/ai_dictionary/controller/ai_dictionary_controller.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class SavingData extends StatelessWidget {
  const SavingData({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final dictionaryController = Get.find<AiDictionaryController>();
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
            langController.selectedLanguage["Saved Words"] ?? "Saved Words",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppDarkColors.primaryColor
                  : AppLightColors.primaryColor,
            ),
          ),
        ),
        body: dictionaryController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : dictionaryController.bookmarkList.isEmpty
            ? Center(
                child: Text(
                 langController.selectedLanguage[ "No saved words yet"] ?? "No saved words yet",
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
              )
            : ListView.separated(
                padding: EdgeInsets.all(16.w),
                itemCount: dictionaryController.bookmarkList.length,
                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  final item = dictionaryController.bookmarkList[index];
                  return Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppDarkColors.backgroundColor
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${index + 1}.",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                item.word ?? "",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (item.syllables != null &&
                            item.syllables!.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(top: 6.h),
                            child: Text(
                              "Syllables: ${item.syllables}",
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                color: isDark ? Colors.white70 : Colors.black87,
                              ),
                            ),
                          ),
                        if (item.meanings != null && item.meanings!.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(top: 6.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Meanings:",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                ),
                                ...item.meanings!.map(
                                  (meaning) => Text(
                                    "- $meaning",
                                    style: GoogleFonts.inter(
                                      fontSize: 13.sp,
                                      color: isDark
                                          ? Colors.white70
                                          : Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (item.englishSentence != null &&
                            item.englishSentence!.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(top: 6.h),
                            child: Text(
                              "English: ${item.englishSentence}",
                              style: GoogleFonts.inter(
                                fontSize: 13.sp,
                                fontStyle: FontStyle.italic,
                                color: isDark ? Colors.white70 : Colors.black87,
                              ),
                            ),
                          ),
                        if (item.sentenceInLanguage != null &&
                            item.sentenceInLanguage!.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: Text(
                              "In Language: ${item.sentenceInLanguage}",
                              style: GoogleFonts.inter(
                                fontSize: 13.sp,
                                fontStyle: FontStyle.italic,
                                color: isDark ? Colors.white70 : Colors.black87,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
      );
    });
  }
}
