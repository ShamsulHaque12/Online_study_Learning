import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../auth/signIn_screen/screens/sign_in_screen.dart';
import '../../component/custom_widgets/custom_button.dart';
import '../../core/app_colours.dart';
import '../../core/app_images.dart';
import '../controller/servey_controller.dart';

class ServeyWelcome extends StatelessWidget {
  ServeyWelcome({super.key});
  final ServeyController controller = Get.put(ServeyController());
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[800] : Colors.grey[200],
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.borderLine, width: 1.w),
              ),
              child: Text(
                "Welcome, ${controller.nameController.text}! Your profile has been successfully created.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 15.h,),
            Image.asset(
              AppImages.pakhi1,
              height: 200.h,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
            Spacer(),
            CustomButton(
              text: "Welcome Home",
              onTap: () {
                Get.off(() => SignInScreen());
              },
              backgroundColor: AppColors.btnBG,
              textColor: Colors.white,
              borderColor: Colors.transparent,
            ),
            SizedBox(height: 20.h),
          ]
        ),
      ),

    );
  }
}
