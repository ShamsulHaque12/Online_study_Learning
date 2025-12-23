import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../../../../component/custom_widgets/custom_button.dart';
import '../../../../../component/custom_widgets/custom_text_field.dart';
import '../../../../../core/app_colours.dart';
import '../controller/lisiting_controller.dart';
import 'lisiting_audio.dart';

class ListeningDrillScreen extends StatelessWidget {
  ListeningDrillScreen({super.key});
  final LisitingController controller = Get.put(LisitingController());

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
          "Writing Practice",
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
            Text(
              "Listing",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.bgLight : Colors.black,
              ),
            ),

            SizedBox(height: 6.h),
            CustomTextField(
              textEditingController: controller.textController,
              hintText: "Write your text here...",
              hintTextColor: isDark ? AppColors.bgLight : AppColors.borderLine,
              fillColor: Colors.transparent,
              borderSide: BorderSide(
                color: isDark ? AppColors.bgLight : AppColors.borderLine,
                width: 1.w,
              ),
              maxLines: 5,
            ),
            SizedBox(height: 6.h),
            SizedBox(height: 20.h),
            CustomButton(
              text: "Continue",
              onTap: () {
                Get.to(()=>LisitingAudio());
              },
              backgroundColor: AppColors.btnBG,
              borderColor: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
