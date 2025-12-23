
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../component/custom_widgets/custom_button.dart';
import '../../../../core/app_colours.dart';
import '../../../../core/app_icons.dart';
import '../controller/choose_word_controller.dart';

class ChooseWordScreen extends StatelessWidget {
  ChooseWordScreen({super.key});

  final ChooseWordController controller = Get.put(ChooseWordController());

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
          "Choose Word",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// PROGRESS BAR
            Obx(
                  () => LinearProgressIndicator(
                value:
                (controller.currentScreen.value + 1) /
                    controller.totalScreens,
                backgroundColor: Colors.grey.shade300,
                minHeight: 6,
                color: AppColors.text2,
              ),
            ),

            SizedBox(height: 10.h),
            Text(
              "Select the correct answer",
              style: GoogleFonts.nunito(
                color: isDark ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
              ),
            ),
            SizedBox(height: 10.h),

            /// SOUND BOX
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: isDark ? Colors.white : Colors.grey,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Text(
                      controller.displayText.value,
                      style: GoogleFonts.nunito(
                        color: isDark ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (controller.selectedIndex.value != -1) {
                        final selectedOption = controller
                            .currentQuiz
                            .options[controller.selectedIndex.value];
                        // TODO: Play sound logic here
                        print("Play sound for: ${selectedOption.title}");
                      }
                    },
                    child: SvgPicture.asset(
                      AppIcons.sound,
                      height: 25.h,
                      width: 25.w,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            /// GRID OF OPTIONS
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.currentQuiz.options.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 0.90,
              ),
              itemBuilder: (context, index) {
                final item = controller.currentQuiz.options[index];

                return Obx(
                  () => GestureDetector(
                    onTap: () => controller.selectOption(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: getOptionColor(index, controller),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(item.image, height: 70.h),
                          SizedBox(height: 10.h),
                          Text(
                            item.title,
                            style: GoogleFonts.nunito(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 20.h),

            /// BUTTON
            Obx(
              () => CustomButton(
                text: controller.buttonText.value,
                onTap: () {
                  if (controller.buttonText.value == "Check") {
                    controller.checkAnswer();
                  } else {
                    controller.nextScreen();
                  }
                },
                backgroundColor: AppColors.center,
                textColor: AppColors.lightText,
                radius: 12.r,
                borderColor: Colors.transparent,
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
