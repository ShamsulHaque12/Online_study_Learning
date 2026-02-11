
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/components/custom_button.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_images.dart';
import 'package:online_study/features/onboarding/onboarding_screen/controller/onbording_controller.dart';
import 'package:online_study/features/onboarding/onboarding_screen/screen/servey_screen2.dart';
import 'package:online_study/global/data/days_name.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class RemaindarTime extends StatelessWidget {
  RemaindarTime({super.key});
  final OnbordingController controller = Get.find<OnbordingController>();

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(() {
      final isDark = themeController.isDark.value;

    return Scaffold(
      backgroundColor: isDark
          ? AppDarkColors.backgroundColor
          : AppLightColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: isDark
            ? AppDarkColors.backgroundColor
            : AppLightColors.backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context), // FIXED
          child: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[400],
                  ),
                  child: Image.asset(
                    AppImages.pencilPutul,
                    width: 100.w,
                    height: 100.h,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    "What day(s) would you like to be reminded to learn?",
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.h),

            // Day Select Row
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(days.length, (index) {
                  bool isSelected = controller.selectedDays.contains(index);

                  return GestureDetector(
                    onTap: () => controller.toggleDay(index),
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: isSelected
                          ? AppDarkColors.primaryColor
                          : Colors.orange.shade100,
                      child: Text(
                        days[index][0],
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : AppDarkColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            SizedBox(height: 20.h),

            Text(
              "What time?",
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),

            SizedBox(height: 20.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Hour wheel
                Obx(
                  () => _timeWheel(
                    selected: controller.selectedHour.value,
                    values: List.generate(12, (i) => i + 1),
                    onChanged: (v) => controller.setHour(v),
                    isDark: isDark,
                  ),
                ),

                SizedBox(width: 20),

                // Minute wheel
                Obx(
                  () => _timeWheel(
                    selected: controller.selectedMinute.value,
                    values: List.generate(60, (i) => i),
                    onChanged: (v) => controller.setMinute(v),
                    isDark: isDark,
                  ),
                ),

                SizedBox(width: 20),

                // AM / PM wheel
                Obx(
                  () => _timeWheel(
                    selected: controller.selectedPeriod.value,
                    values: ["AM", "PM"],
                    onChanged: (v) => controller.setPeriod(v),
                    isDark: isDark,
                  ),
                ),
              ],
            ),

            Spacer(),

            CustomButton(
              text: "Continue",
              onPressed: () {
                if (controller.selectedDays.isEmpty) {
                  Get.snackbar(
                    "Select Day",
                    "Please select at least one day for reminder.",
                    backgroundColor: Colors.redAccent,
                    colorText: Colors.white,
                  );
                  return;
                }
                Get.to(() => ServeyScreen2());
              },
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
    });
  }

  Widget _timeWheel({
    required dynamic selected,
    required List values,
    required Function(dynamic) onChanged,
    required bool isDark,
  }) {
    return SizedBox(
      width: 60,
      height: 140,
      child: ListWheelScrollView.useDelegate(
        itemExtent: 40,
        physics: FixedExtentScrollPhysics(),
        onSelectedItemChanged: (index) {
          onChanged(values[index]);
        },
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: values.length,
          builder: (context, index) {
            bool isActive = values[index] == selected;

            return Center(
              child: Text(
                values[index].toString(),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
                  color: isActive
                      ? Colors.orange
                      : (isDark
                            ? Colors.white.withOpacity(0.3)
                            : Colors.grey.shade400),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
