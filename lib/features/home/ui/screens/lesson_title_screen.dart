
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_images.dart';
import 'package:online_study/features/home/controller/lesson_controller.dart';
import 'package:online_study/features/home/model/get_chapter1_data.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/features/lesson_content/model/content_model.dart';
import 'package:online_study/route/app_routes.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class LessonTitleScreen extends StatelessWidget {
  LessonTitleScreen({super.key});
  final langController = Get.find<LanguageController>();
  final LessonController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final int chapterNum = int.tryParse(Get.arguments?.toString() ?? '1') ?? 1;

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
            onPressed: Get.back,
            icon: Icon(
              Icons.arrow_back_ios,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          title: Text(
            langController.selectedLanguage["Lessons"]!,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppDarkColors.primaryTextColor
                  : AppLightColors.primaryTextColor,
            ),
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: SpinKitCircle(color: AppDarkColors.primaryColor),
            );
          }

          final filteredChapters = controller.chapters
              .where((c) => c.chapter == chapterNum)
              .toList();

          if (filteredChapters.isEmpty) {
            return const Center(child: Text("No lessons found"));
          }

          return ListView.separated(
            padding: EdgeInsets.all(12.w),
            itemCount: filteredChapters.length,
            separatorBuilder: (_, __) => SizedBox(height: 10.h),
            itemBuilder: (context, index) {
              final chapter = filteredChapters[index];

              return GestureDetector(
                onTap: () => _openLesson(chapter),
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[900] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Image.asset(AppImages.mans, width: 60.w, height: 60.h),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          chapter.titles.en,
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      if (chapter.titles.en.toLowerCase() == "challenge")
                        Icon(
                          Icons.bolt,
                          color: Colors.orangeAccent,
                          size: 22.sp,
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      );
    });
  }

  /// ==========================
  /// Navigation Logic
  /// ==========================
  void _openLesson(ChapterData chapter) async {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.isDark.value;
    // ✅ Challenge screen
    if (chapter.titles.en.toLowerCase() == "challenge") {
      Get.toNamed(AppRoutes.challengesScreen, arguments: chapter);
      return;
    }

    // ✅ Normal lesson → show loading dialog
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.grey[900]
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(AppImages.pakhi, width: 90.w),
              SizedBox(height: 12.h),
              Text(
                "Loading lesson...",
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10.h),
              const LinearProgressIndicator(minHeight: 6),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );

    final lessonData = await Future.wait([
      controller.fetchLessonById(chapter.id),
      Future.delayed(const Duration(seconds: 1)),
    ]).then((results) => results[0] as ContentModel?);

    if (Get.isDialogOpen ?? false) Get.back();

    if (lessonData != null) {
      Get.toNamed(AppRoutes.lessonContentScreen, arguments: lessonData);
    }
  }
}
