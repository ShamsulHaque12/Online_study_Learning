
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_images.dart';
import 'package:online_study/features/ai_screens/ai_dictionary/controller/ai_dictionary_controller.dart';
import 'package:online_study/features/ai_screens/ai_dictionary/screens/saving_data.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class AiDictionaryScreen extends StatelessWidget {
  AiDictionaryScreen({super.key});

  final AiDictionaryController controller = Get.put(AiDictionaryController());
  final langController = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      final isDark = themeController.isDark.value;
      return Scaffold(
        backgroundColor: isDark
            ? AppDarkColors.backgroundColor
            : AppLightColors.backgroundColor,

        /// APP BAR
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
            langController.selectedLanguage["AI Dictionary"] ?? "AI Dictionary",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppDarkColors.primaryColor
                  : AppLightColors.primaryColor,
            ),
          ),
        ),

        /// BODY
        body: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔍 SEARCH BAR
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50.h,
                      child: TextFormField(
                        controller: controller.searchController,

                        style: TextStyle(
                          fontSize: 14.sp,
                          color: isDark
                              ? AppDarkColors.primaryTextColor
                              : AppLightColors.primaryTextColor,
                        ),
                        decoration: InputDecoration(
                          hintText: "Search for a word...",
                          hintStyle: TextStyle(
                            fontSize: 14.sp,
                            color: isDark
                                ? AppDarkColors.primaryColor
                                : AppLightColors.primaryColor,
                          ),

                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 14.h,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        onChanged: (v) {
                          if (v.isEmpty) {
                            controller.dictionaryData.value = null;
                          }
                        },
                      ),
                    ),
                  ),

                  SizedBox(width: 10.w),

                  SizedBox(
                    height: 45.h,
                    width: 100.w,
                    child: ElevatedButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        controller.searchWord();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppLightColors.tealColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        "Search",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Get.to(() => SavingData());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      langController.selectedLanguage["Saving Words"] ?? "Saving Words",
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppDarkColors.primaryTextColor
                            : AppLightColors.primaryTextColor,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              /// 📌 EMPTY STATE
              Obx(() {
                if (controller.dictionaryData.value != null ||
                    controller.isLoading.value) {
                  return const SizedBox();
                }

                return Column(
                  children: [
                    Image.asset(AppImages.pencilPutul, height: 150.h),
                    SizedBox(height: 10.h),
                    Text(
                      langController.selectedLanguage["Start Your Learning Journey"] ?? "Start Your Learning Journey",
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppLightColors.tealColor,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      langController.selectedLanguage["Search for any word to see its meaning, pronunciation and examples."] ?? "Search for any word to see its meaning, pronunciation and examples.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(fontSize: 14.sp),
                    ),
                  ],
                );
              }),

              /// ⏳ LOADING
              Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                    child: SpinKitCircle(color: AppDarkColors.primaryColor),
                  );
                }
                return const SizedBox();
              }),

              /// ❌ ERROR
              Obx(() {
                if (controller.errorMessage.value.isNotEmpty) {
                  return Center(
                    child: Text(
                      controller.errorMessage.value,
                      style: TextStyle(color: Colors.red, fontSize: 16.sp),
                    ),
                  );
                }
                return const SizedBox();
              }),

              /// ✅ RESULT
              Obx(() {
                final data = controller.dictionaryData.value;
                if (data == null) return const SizedBox();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          data.word ?? "",
                          style: GoogleFonts.inter(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? AppDarkColors.primaryTextColor
                                : AppLightColors.primaryTextColor,
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Obx(
                          () => GestureDetector(
                            onTap: controller.isBookmarked.value
                                ? null 
                                : () {
                                    controller.saveDataToDatabase();
                                  },
                            child: Container(
                              padding: EdgeInsets.all(6.w),
                              decoration: BoxDecoration(
                                color: controller.isBookmarked.value
                                    ? AppDarkColors.primaryColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Image.asset(
                                "assets/images/bookmark.png",
                                height: 20.h,
                                width: 20.w,
                                color: controller.isBookmarked.value
                                    ? Colors.white
                                    : null,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 20.w),
                        GestureDetector(
                          onTap: () {
                            controller.speakWord(data.word ?? "");
                          },
                          child: Image.asset(
                            "assets/images/sounds.png",
                            height: 20.h,
                            width: 20.w,
                          ),
                        ),
                        Spacer(),
                        // Container(
                        //   padding: EdgeInsets.all(5),
                        //   decoration: BoxDecoration(
                        //     color: Color(0xFFA5D8FF),
                        //     borderRadius: BorderRadius.circular(8.r),
                        //   ),
                        //   child: Text(
                        //     "Noun",
                        //     style: TextStyle(
                        //       fontSize: 14.sp,
                        //       fontWeight: FontWeight.w600,
                        //       color: Colors.black,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),

                    SizedBox(height: 5.h),

                    Text(
                      "/${data.syllables ?? ""}/",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: isDark
                            ? AppDarkColors.primaryTextColor
                            : AppLightColors.primaryTextColor,
                      ),
                    ),

                    Divider(
                      thickness: 1,
                      color: isDark
                          ? AppDarkColors.iconColor
                          : AppLightColors.iconeColor,
                    ),

                    SizedBox(height: 10.h),

                    Row(
                      children: [
                        Image.asset(
                          "assets/images/book.png",
                          height: 20.h,
                          width: 20.w,
                          color: isDark
                              ? AppDarkColors.primaryTextColor
                              : AppLightColors.primaryTextColor,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          langController.selectedLanguage["Meaning"] ?? "Meaning",
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? AppDarkColors.primaryTextColor
                                : AppLightColors.primaryTextColor,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 6.h),

                    if (data.meanings != null)
                      ...data.meanings!.map(
                        (m) => Text(
                          "• $m",
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            color: isDark
                                ? AppDarkColors.primaryTextColor
                                : AppLightColors.primaryTextColor,
                          ),
                        ),
                      ),

                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/light.png",
                          height: 20.h,
                          width: 20.w,
                          color: isDark
                              ? AppDarkColors.primaryColor
                              : AppLightColors.primaryColor,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          langController.selectedLanguage["Example"] ?? "Example",
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? AppDarkColors.primaryColor
                                : AppLightColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),

                    _exampleBox(
                      title: "English",
                      text: data.englishSentence ?? "",
                    ),

                    SizedBox(height: 8.h),

                    _exampleBox(
                      title: "Sentence in Language",
                      text: data.sentenceInLanguage ?? "",
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      );
    });
  }

  /// 🔹 Example Container
  Widget _exampleBox({required String title, required String text}) {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.isDark.value;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDark
            ? AppDarkColors.btnColor
            : AppLightColors.lightGrayTextColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title:",
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppLightColors.tealColor,
            ),
          ),
          SizedBox(height: 4.h),
          Text(text, style: TextStyle(fontSize: 15.sp)),
        ],
      ),
    );
  }
}
