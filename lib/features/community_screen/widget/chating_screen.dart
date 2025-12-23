import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../component/custom_widgets/custom_text_field.dart';
import '../../../core/app_colours.dart';
import '../controller/chat_controller.dart';

class ChatingScreen extends StatelessWidget {
  ChatingScreen({super.key});

  final ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              textEditingController: controller.searchController,
              hintText: "Search",
              hintTextColor: AppColors.btnTextBule,
              fillColor: Colors.transparent,
              borderSide: BorderSide(color: AppColors.btnTextBule, width: 1),
            ),

            SizedBox(height: 10.h),

            /// TABS
            Obx(() {
              return Row(
                children: [
                  buildTab("Personal Chat", 0),
                  SizedBox(width: 10),
                  buildTab("Group Chat", 1),
                ],
              );
            }),

            SizedBox(height: 10.h),

            /// FIX: Use Expanded but not inside scroll view
            Expanded(
              child: Obx(
                () => controller.screens[controller.selectedIndex.value],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Tab Button Widget
  Widget buildTab(String title, int index) {
    bool isActive = controller.selectedIndex.value == index;

    return GestureDetector(
      onTap: () => controller.selectedIndex.value = index,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.orange : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isActive ? Colors.orange : Colors.grey.withOpacity(0.4),
          ),
          // boxShadow: isActive
          //     ? [
          //         BoxShadow(
          //           color: Colors.orange.withOpacity(0.4),
          //           blurRadius: 6,
          //           offset: Offset(0, 3),
          //         ),
          //       ]
          //     : [],
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}
