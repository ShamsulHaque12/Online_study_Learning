
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:online_study/components/custom_button.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_images.dart';
import 'package:online_study/features/lesson_content/controller/lessont_content_controller.dart';
import 'package:online_study/features/lesson_content/model/content_model.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class LessonContentScreen extends StatelessWidget {
  LessonContentScreen({super.key});
  final LessontContentController controller = Get.put(
    LessontContentController(),
  );

  @override
  Widget build(BuildContext context) {
    final lessonData = Get.arguments as ContentModel?;
    final themeController = Get.find<ThemeController>();

    if (lessonData == null) {
      return const Scaffold(body: Center(child: Text("No lesson data")));
    }

    controller.content = lessonData;

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
          lessonData.data?.titles?.en ?? "Lesson Content",
          style: TextStyle(
            color: isDark
                ? AppDarkColors.primaryTextColor
                : AppLightColors.primaryTextColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: SpinKitCircle(color: AppDarkColors.primaryColor),
            );
          }
          final lessons = controller.lessons;
          if (lessons.isEmpty) {
            return Center(
              child: Text(
                "No Lessons",
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
              ),
            );
          }
          return Column(
            children: [
              Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 16.w,
                  vertical: 15.h,
                ),
                child: LinearProgressIndicator(
                  value: lessons.isEmpty
                      ? 0
                      : (controller.currentIndex.value + 1) / lessons.length,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  physics: NeverScrollableScrollPhysics(),
                  onPageChanged: controller.onPageChanged,
                  itemCount: lessons.length,
                  itemBuilder: (_, index) {
                    final word = lessons[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        lessonImage(word.image),
                        SizedBox(height: 20.h),

                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            //color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Colors.grey),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (word.ltWord != null)
                                Text(
                                  word.ltWord!,
                                  style: TextStyle(
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              SizedBox(height: 4.h),
                              if (word.enWord != null)
                                Text(
                                  word.enWord!,
                                  style: TextStyle(fontSize: 22.sp),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.h),

                        /// Arrows
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                                onPressed: controller.currentIndex.value == 0
                                    ? null
                                    : controller.previousPage,
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                                onPressed:
                                    controller.currentIndex.value ==
                                        lessons.length - 1
                                    ? null
                                    : controller.nextPage,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),

                        /// 🔊 Sound
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppDarkColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.volume_up, size: 34.sp),
                            onPressed: word.enWord != null
                                ? () => controller.speak(word.enWord!)
                                : null,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              /// Complete Button....
              if (controller.currentIndex.value == lessons.length - 1)
                CustomButton(
                  text: "Complete Lesson",
                  onPressed: controller.completeLesson,
                ),

              SizedBox(height: 50),
            ],
          );
        }),
      ),
    );
    });
  }

  Widget lessonImage(String? imageUrl) {
    return imageUrl != null && imageUrl.isNotEmpty
        ? Image.network(
            imageUrl,
            height: 200.h,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                AppImages.defaultImage, // fallback asset image
                height: 200.h,
                fit: BoxFit.cover,
              );
            },
          )
        : Image.asset(
            AppImages.defaultImage, // image null hole asset image
            height: 200.h,
            fit: BoxFit.cover,
          );
  }
}
