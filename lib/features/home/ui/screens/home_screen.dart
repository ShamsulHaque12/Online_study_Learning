
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_study/components/lesson_chapter_container.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/home/controller/lesson_controller.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/global/widgets/custom_appbar.dart';
import 'package:online_study/route/app_routes.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final themeController = Get.find<ThemeController>();
  final LessonController controller = Get.put(LessonController());
  final langController = Get.find<LanguageController>();

  List<Map<String, dynamic>> chapters = [];

  @override
  void initState() {
    super.initState();
    chapters = [
      {
        "title": langController.selectedLanguage["Chapter 1 (Beginner A1)"],
        "subtitle": langController.selectedLanguage["Introduction of Tagalog"],
        "color": AppDarkColors.primaryColor,
        "chapterNumber": "1",
      },
      {
        "title": langController.selectedLanguage["Chapter 2 (A1 → A2)"],
        "subtitle": langController.selectedLanguage["Action, Time and Place"],
        "color": Color(0xff1C7ED6),
        "chapterNumber": "2",
      },
      {
        "title":
            langController.selectedLanguage["Chapter 3 (INTERMEDIATE A2 → B1)"],
        "subtitle": langController.selectedLanguage["Family and Relationships"],
        "color": Color(0xff9D28AC),
        "chapterNumber": "3",
      },
      {
        "title": langController.selectedLanguage["Chapter 4 (B1 → B2)"],
        "subtitle": langController
            .selectedLanguage["Expressing Gratitude and Apologies"],
        "color": Color(0xffD90673),
        "chapterNumber": "4",
      },
      {
        "title":
            langController.selectedLanguage["Chapter 5 (ADVANCED B2 → C1)"],
        "subtitle": langController.selectedLanguage["Grammar Focus"],
        "color": Color(0xff17B5B4),
        "chapterNumber": "5",
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDarkMode = themeController.isDark.value;

      return Scaffold(
        backgroundColor: isDarkMode
            ? AppDarkColors.backgroundColor
            : AppLightColors.backgroundColor,
        appBar: CustomAppBar(
          fireCount: controller.user.value?.streak ?? 0,
          notoCount: controller.user.value?.totalPoint ?? 0,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Obx(() {
                      return Text(
                        langController.selectedLanguage["Lesson"]!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode
                              ? AppDarkColors.primaryTextColor
                              : AppLightColors.primaryTextColor,
                        ),
                      );
                    }),
                  ],
                ),
                SizedBox(height: 12.h),
                Obx(() {
                  return Column(
                    children: chapters.map((chapter) {
                      final chapterNum = int.parse(
                        chapter['chapterNumber'] as String,
                      );

                      // get dynamic percentage from controller
                      final percentage =
                          controller.chapterPercentages[chapterNum + 1] ?? 0;
                      print(
                        "Controller chapterPercent $chapterNum: $percentage",
                      );

                      return Column(
                        children: [
                          LessonChapterContainer(
                            chapterTitle: chapter['title'] as String,
                            chapterSubtitle: chapter['subtitle'] as String?,
                            progressText:
                                '$percentage%', // <-- dynamic percentage
                            containerColor: chapter['color'] as Color,
                            onPressed: () {
                              Get.toNamed(
                                AppRoutes.lessonTitleScreen,
                                arguments: chapter['chapterNumber'],
                              );
                            },
                          ),
                          SizedBox(height: 16.h),
                        ],
                      );
                    }).toList(),
                  );
                }),
              ],
            ),
          ),
        ),
      );
    });
  }
}
