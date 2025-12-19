
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_study/survey_screen/screens/servey_title_text.dart';

import '../../component/custom_widgets/custom_button.dart';
import '../../core/app_colours.dart';
import '../../core/app_images.dart';
import '../controller/servey_controller.dart';

class ServeyRemainder extends StatelessWidget {
  ServeyRemainder({super.key});

  final ServeyController controller = Get.put(ServeyController());
  final List<String> days = ["M", "T", "W", "T", "F", "S", "S"];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
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
                CircleAvatar(
                  radius: 40.r,
                  backgroundImage: AssetImage(AppImages.putul),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    "What day(s) would you like to be reminded to learn?",
                    style: TextStyle(
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
                          ? AppColors.btnBG
                          : Colors.orange.shade100,
                      child: Text(
                        days[index],
                        style: TextStyle(
                          color: isSelected ? Colors.white : AppColors.btnBG,
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
              style: TextStyle(
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
              onTap: () {
                Get.to(() => ServeyTitleText());
                print("Selected Days: ${controller.selectedDays}");
                print(
                  "Selected Time: "
                  "${controller.selectedHour.value}:"
                  "${controller.selectedMinute.value} "
                  "${controller.selectedPeriod.value}",
                );
              },
              backgroundColor: AppColors.btnBG,
              textColor: Colors.white,
              borderColor: Colors.transparent,
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
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
