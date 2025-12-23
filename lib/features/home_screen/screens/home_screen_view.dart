
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../component/custom_widgets/custom_button.dart';
import '../../../core/app_colours.dart';
import '../../../core/app_icons.dart';
import '../../../core/app_images.dart';
import '../challenge_screen/screen/challenge_screen.dart';
import '../controller/home_screen_controller.dart';
import 'lesson_details_page.dart';

class HomeScreenView extends StatelessWidget {
  final HomeScreenController controller = Get.put(HomeScreenController());
  HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network('https://flagcdn.com/w80/gb.png'),
        ),
        elevation: 0,
        actions: [
          SvgPicture.asset(AppIcons.agun, height: 20.h, width: 20.w),
          const SizedBox(width: 5),
          Text(
            "2",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : AppColors.lightText,
            ),
          ),
          const SizedBox(width: 10),
          SvgPicture.asset(AppIcons.egg, height: 20.h, width: 20.w),
          const SizedBox(width: 5),
          Text(
            "2",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : AppColors.lightText,
            ),
          ),
          const SizedBox(width: 70),
          SvgPicture.asset(
            AppIcons.notification,
            height: 20.h,
            width: 20.w,
            color: isDark ? Colors.white : AppColors.lightText,
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 20.r,
            backgroundImage: AssetImage(AppImages.putul),
          ),
          const SizedBox(width: 10),
        ],
      ),

      body: Obx(
        () => ListView(
          padding: EdgeInsets.all(15),
          children: [
            Text(
              "Lessons",
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.btnBG,
              ),
            ),
            SizedBox(height: 15.h),
            ...List.generate(controller.chapters.length, (chapterIndex) {
              var chapter = controller.chapters[chapterIndex] as Map;
              var items = chapter['items'] as List;
              return Column(
                children: [
                  _buildChapterHeader(chapter),
                  ...List.generate(
                    items.length,
                    (lessonIndex) => _buildLessonItem(
                      items[lessonIndex],
                      chapterIndex,
                      lessonIndex,
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildChapterHeader(Map chapter) {
    final isDark = Theme.of(Get.context!).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: chapter['color'],
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chapter['title'],
                  style: GoogleFonts.inter(
                    color: AppColors.chTitle,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  chapter['subtitle'],
                  style: GoogleFonts.nunito(
                    color: isDark ? Colors.black : AppColors.chSubTitle,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 100.w,
                height: 80.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
              Text(
                "${chapter['progress']}%",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLessonItem(Map item, int chapterIndex, int lessonIndex) {
    final isDark = Theme.of(Get.context!).brightness == Brightness.dark;
    bool locked = item['isLocked'] && !item['isChallenge'];
    String image = item['isChallenge']
        ? AppIcons.star
        : locked
        ? AppIcons.lock
        : AppIcons.men;

    return InkWell(
      onTap: () {
        if (locked && !controller.isSubscriber.value) {
         _showPopUpDialog(Get.context!);
          return;
        }
        // If Challenge → go to challenge screen
        if (item['isChallenge'] == true) {
          Get.to(() => ChallengeScreen(
            lessonTitle: item['title'],
          ));
          return;
        }

        showLoadingPopup(() {
          controller.completeLesson(chapterIndex, lessonIndex);
          Get.to(() => LessonDetailPage(lessonTitle: item['title']));
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22.r,
              backgroundColor: Colors.transparent,
              child: Image.asset(image, width: 60.w, height: 60.h),
            ),
            SizedBox(width: 15),
            Flexible(
              child: Text(
                item['title'],
                style: GoogleFonts.nunito(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: locked
                      ? Colors.grey
                      : (isDark ? Colors.white : Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showLoadingPopup(Function onComplete) {
    final isDark = Theme.of(Get.context!).brightness == Brightness.dark;
    Get.dialog(
      Dialog(
        backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: Duration(seconds: 2),
            builder: (context, value, child) {
              if (value == 1) {
                Future.delayed(Duration(milliseconds: 200), () {
                  Get.back();
                  onComplete();
                });
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(AppImages.pakhi1, height: 150.h, width: 150.w),
                  Text(
                    "Loading...",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.btnBG,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Ready to level up? Finish this lesson and see what awaits you!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white : AppColors.lightText,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  LinearProgressIndicator(value: value),
                  SizedBox(height: 10.h),
                  Text(
                    "${(value * 100).toInt()}%",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white : AppColors.lightText,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  void _showPopUpDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(AppIcons.subpop, height: 100.h, width: 100.w),
                SizedBox(height: 10.h),
                Text(
                  "Premium Content",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.lightText,
                  ),
                ),
                SizedBox(height: 5.h,),
                Text(
                  "Upgrade your plan to unlock all courses and premium contents.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: isDark ? Colors.white : AppColors.lightText,
                  ),
                ),
                SizedBox(height: 5.h,),
                CustomButton(
                  onTap: (){},
                  text: "Update Plan",
                  textColor: AppColors.bgLight,
                  backgroundColor: AppColors.btnBG,
                  borderColor: Colors.transparent,
                  radius: 12.r,
                ),
                SizedBox(height: 5.h,),
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Text(
                    "Maybe Later",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF17B5B4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    // 2 সেকেন্ড পরে popup close করে HomeScreen navigate
    // Future.delayed(Duration(seconds: 2), () {
    //   Navigator.of(context).pop();
    //   Get.off(() => HomeScreenView());
    // });
    // Future.delayed(Duration(seconds: 2), () {
    //   Navigator.of(context).pop();
    //   controller.update(); // refresh GetX UI
    // });

  }

}
