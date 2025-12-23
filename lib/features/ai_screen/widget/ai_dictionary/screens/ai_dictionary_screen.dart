
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../core/app_colours.dart';
import '../../../../../core/app_icons.dart';
import '../../../../../core/app_images.dart';
import '../controller/dictionary_controller.dart';

class AiDictionaryScreen extends StatelessWidget {
  final DictionaryController controller = Get.put(DictionaryController());
  AiDictionaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
        leading: IconButton(
          onPressed: () =>Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          "Ai Dictionary",
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
            /// SEARCH SECTION
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50.h,
                    child: TextField(
                      controller: controller.searchController,
                      style: TextStyle(fontSize: 14.sp),
                      onChanged: (value) {
                        if (value.isEmpty) {
                          controller.result.value = "";
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Search for a word...",
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: isDark
                                ? AppColors.bgLight
                                : AppColors.borderLine,
                            width: 1.w,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF1FB8B7),
                            width: 1.w,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 10.w),

                GestureDetector(
                  onTap: () => controller.searchWord(),
                  child: Image.asset(
                    AppIcons.scearch,
                    height: 40.h,
                    width: 40.w,
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Saving Words",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.bgLight : Colors.black,
                  ),
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
            SizedBox(height: 10.h),

            /// SHOW THIS ONLY WHEN SEARCH RESULT IS EMPTY
            Obx(() {
              if (controller.result.value.isNotEmpty) {
                return SizedBox(); // hide
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      AppImages.pencil_putul,
                      height: 150.h,
                      width: 150.w,
                    ),
                  ),

                  SizedBox(height: 6.h),

                  Center(
                    child: Text(
                      "Start Your Learning Journey",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grammer,
                      ),
                    ),
                  ),

                  SizedBox(height: 6.h),

                  Center(
                    child: Text(
                      "Search for any word to see its meaning, pronunciation,and examples.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppColors.bgLight
                            : AppColors.borderLine,
                      ),
                    ),
                  ),
                ],
              );
            }),

            SizedBox(height: 10.h),

            /// RESULT SECTION
            Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              if (controller.result.value.isEmpty) {
                return SizedBox();
              }

              return Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          controller.searchController.text,
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                            color: isDark ? AppColors.bgLight : Colors.black,
                          ),
                        ),
                        SizedBox(width: 20.w),
                        SvgPicture.asset(
                          AppIcons.bookmark,
                          height: 20.h,
                          width: 20.w,
                        ),
                        SizedBox(width: 20.w),
                        SvgPicture.asset(
                          AppIcons.sound,
                          height: 20.h,
                          width: 20.w,
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Color(0xFFA5D8FF),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            "Noun",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      "/word/",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: isDark ? AppColors.bgLight : Colors.black,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Divider(
                      thickness: 1,
                      color: isDark ? AppColors.bgLight : Colors.black,
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppIcons.book,
                          height: 20.h,
                          width: 20.w,
                          color: isDark ? AppColors.bgLight : Colors.black,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          "Meaning",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: isDark ? AppColors.bgLight : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Meaning",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: isDark ? AppColors.borderLine : Colors.black,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      "OR",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppColors.bgLight : Colors.black,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      "Example Sentence",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: isDark ? AppColors.borderLine : Colors.black,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppIcons.light,
                          height: 20.h,
                          width: 20.w,
                          color: isDark ? AppColors.bgLight : Colors.black,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          "Example",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: isDark ? AppColors.bgLight : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.containerdark
                            : AppColors.borderLine,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tagalog:",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.grammer,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "change Language",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: isDark ? AppColors.bgLight : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.containerdark
                            : AppColors.borderLine,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "English:",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.grammer,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "change Language",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: isDark ? AppColors.bgLight : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      controller.result.value,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
