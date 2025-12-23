
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../component/custom_widgets/custom_button.dart';
import '../../../../../component/custom_widgets/custom_text_field.dart';
import '../../../../../core/app_colours.dart';
import '../../../../../core/app_icons.dart';
import '../controller/dialogue_controller.dart';
import 'genaret_dialogue.dart';

class DialogueBuilderScreen extends StatelessWidget {
  final DialogueController controller = Get.put(DialogueController());
  DialogueBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          'Dialogue Builder',
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
              "Dialogue Topic",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.bgLight : Colors.black,
              ),
            ),
            SizedBox(height: 10.h),
            CustomTextField(
              textEditingController: controller.dialogueController,
              hintText: "Write your dialogue here...",
              maxLines: 2,
              hintTextColor: isDark ? AppColors.bgLight : Colors.black54,
              fillColor: Colors.transparent,
              textColor: isDark ? AppColors.bgLight : Colors.black,
              borderSide: BorderSide(
                color: isDark ? AppColors.btnTextBule : Colors.black,
                width: 1.w,
              ),
            ),
            SizedBox(height: 20.h),
            CustomButton(
              text: "Generate Dialogue",
              onTap: () {
                Get.to(() => GenaretDialogue());
              },
              backgroundColor: AppColors.btnBG,
              suffixIcon: SvgPicture.asset(
                AppIcons.simul,
                height: 20.h,
                width: 20.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
