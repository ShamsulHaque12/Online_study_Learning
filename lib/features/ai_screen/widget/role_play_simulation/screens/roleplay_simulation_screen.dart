
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_study/features/ai_screen/widget/role_play_simulation/screens/role_play_screen.dart';
import '../../../../../component/custom_widgets/custom_button.dart';
import '../../../../../component/custom_widgets/custom_text_field.dart';
import '../../../../../core/app_colours.dart';
import '../controller/role_play_controller.dart';

class RoleplaySimulationScreen extends StatelessWidget {
  final RolePlayController controller = Get.put(RolePlayController());
  RoleplaySimulationScreen({super.key});

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
          'Roleplay Simulation',
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
              "Roleplay",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.bgLight : Colors.black,
              ),
            ),
            SizedBox(height: 10.h),
            CustomTextField(
              textEditingController: controller.roleController,
              hintText: "Write your role here...",
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
              text: "Submit",
              onTap: () {
                Get.to(()=>RolePlayScreen());
              },
              backgroundColor: AppColors.btnBG,
            )
          ],
        ),
      ),
    );
  }
}
