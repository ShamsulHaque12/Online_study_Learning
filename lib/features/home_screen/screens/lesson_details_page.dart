import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/app_colours.dart';
import '../../../core/app_icons.dart';
import '../controller/lesson_details_controller.dart';

class LessonDetailPage extends StatelessWidget {
  final LessonDetailsController controller = Get.put(LessonDetailsController());
  final String lessonTitle;

  LessonDetailPage({super.key, required this.lessonTitle});

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
          lessonTitle,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            /// PROGRESS BAR
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${controller.currentIndex.value + 1}/${controller.words.length}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      Text(
                        '${(controller.progress * 100).toInt()}%',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  LinearProgressIndicator(
                    value: controller.progress,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    minHeight: 8.h,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ],
              ),
            ),

            /// PAGE CONTENT
            Expanded(
              child: PageView.builder(
                onPageChanged: controller.onPageChanged,
                itemCount: controller.words.length,
                itemBuilder: (_, index) {
                  final word = controller.words[index];
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 40.h),

                        /// IMAGE
                        Image.asset(word.image, height: 250.h),

                        SizedBox(height: 20.h),

                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.bgDark : Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              /// WORD TEXT
                              Text(
                                word.word,
                                style: TextStyle(
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w700,
                                  color: isDark ? AppColors.bgLight : Colors.black,
                                ),
                              ),

                              SizedBox(height: 5),

                              /// TRANSLATION TEXT (Speech To Text Live Update)
                              Obx(
                                    () => Text(
                                  controller.words[index].translation,
                                  style: TextStyle(
                                    fontSize: 22.sp,
                                    color: isDark ? AppColors.bgLight : Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// WAVEFORM ANIMATION
                        Obx(() {
                          if (controller.isListening.value) {
                            return Padding(
                              padding: EdgeInsets.only(top: 20.h),
                              child: WaveformAnimation(),
                            );
                          }
                          return SizedBox.shrink();
                        }),
                      ],
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 10.h),

            /// 🔘 BUTTONS SECTION
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Obx(() {
                  // Show Complete Button if on last page
                  if (controller.currentIndex.value == controller.words.length - 1) {
                    return Column(
                      children: [
                        // Audio buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            /// 🔊 SPEAK TRANSLATION
                            GestureDetector(
                              onTap: () => controller.speakText(
                                controller.currentWord.translation,
                              ),
                              child: SvgPicture.asset(AppIcons.sound, height: 55.h),
                            ),

                            /// 🎤 MIC → LIVE TRANSLATION
                            GestureDetector(
                              onTap: () => controller.startListening(),
                              child: SvgPicture.asset(AppIcons.mic, height: 55.h),
                            ),
                          ],
                        ),

                        SizedBox(height: 20.h),

                        // Complete Button
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.w),
                          child: ElevatedButton(
                            onPressed: () => controller.showCompletionPopup(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              minimumSize: Size(double.infinity, 50.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.check_circle, size: 24.sp),
                                SizedBox(width: 8.w),
                                Text(
                                  'Complete Lesson',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  // Show normal buttons on other pages
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      /// 🔊 SPEAK TRANSLATION
                      GestureDetector(
                        onTap: () => controller.speakText(
                          controller.currentWord.translation,
                        ),
                        child: SvgPicture.asset(AppIcons.sound, height: 55.h),
                      ),

                      /// 🎤 MIC → LIVE TRANSLATION
                      GestureDetector(
                        onTap: () => controller.startListening(),
                        child: SvgPicture.asset(AppIcons.mic, height: 55.h),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ],
        );
      }),
    );
  }
}

/// WAVEFORM ANIMATION WIDGET
class WaveformAnimation extends StatefulWidget {
  @override
  _WaveformAnimationState createState() => _WaveformAnimationState();
}

class _WaveformAnimationState extends State<WaveformAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(5, (index) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              double delay = index * 0.2;
              double animValue = (_controller.value + delay) % 1.0;
              double height =
                  10 + (50 * (0.5 + 0.5 * (animValue * 2 - 1).abs()));

              return Container(
                width: 6.w,
                height: height,
                margin: EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(3.r),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}