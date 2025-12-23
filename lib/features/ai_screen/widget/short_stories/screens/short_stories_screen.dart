
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../component/custom_widgets/custom_button.dart';
import '../../../../../component/custom_widgets/custom_text_field.dart';
import '../../../../../core/app_colours.dart';
import '../../../../../core/app_icons.dart';
import '../controller/strories_controller.dart';

class ShortStoriesScreen extends StatelessWidget {
  final StoriesController controller = Get.put(StoriesController());
  ShortStoriesScreen({super.key});

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
          "Short Stories",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// TOPIC + LANGUAGE SWITCH
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Story Topic",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.bgLight : Colors.black,
                  ),
                ),

                Row(
                  children: [
                    CustomButton(
                      height: 28.h,
                      width: MediaQuery.sizeOf(context).width * 0.20,
                      text: "ENG",
                      onTap: () {},
                      backgroundColor: AppColors.grammer,
                      borderColor: Colors.transparent,
                    ),

                    SizedBox(width: 6.w),

                    SvgPicture.asset(
                      AppIcons.exchange,
                      height: 22.h,
                      width: 22.w,
                    ),

                    SizedBox(width: 6.w),

                    CustomButton(
                      height: 28.h,
                      width: MediaQuery.sizeOf(context).width * 0.20,
                      text: "TAG",
                      onTap: () {},
                      backgroundColor: AppColors.grammer,
                      borderColor: Colors.transparent,
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 15.h),

            /// STORY INPUT FIELD
            CustomTextField(
              textEditingController: controller.storiesController,
              hintText: "Write your story here...",
              maxLines: 5,
              hintTextColor: isDark ? AppColors.bgLight : Colors.black54,
              fillColor: Colors.transparent,
              textColor: isDark ? AppColors.bgLight : Colors.black,
              borderSide: BorderSide(
                color: isDark ? AppColors.btnTextBule : Colors.black,
                width: 1.w,
              ),
            ),

            SizedBox(height: 20.h),

            /// SUBMIT BUTTON
            CustomButton(
              text: "Submit",
              onTap: () {},
              backgroundColor: AppColors.btnBG,
            ),
          ],
        ),
      ),
    );
  }
}
