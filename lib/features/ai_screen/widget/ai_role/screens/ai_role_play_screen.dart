import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/app_colours.dart';
import '../containar/ai_role_containar.dart';

class AiRolePlayScreen extends StatelessWidget {
  final AiRoleContainar controller = Get.put(AiRoleContainar());

  AiRolePlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
        title: const Text("AI Role Play"),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          /// -------- CHAT LIST --------
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: const EdgeInsets.all(12),
                reverse: true,
                itemCount: controller.chatMessages.length,
                itemBuilder: (context, index) {
                  final msg = controller.chatMessages[index];
                  final sender = msg["sender"];
                  final text = msg["text"] ?? "";

                  bool isUser = sender == "user";

                  return Align(
                    alignment: isUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isUser
                            ? Colors.blueAccent.withOpacity(0.2)
                            : Colors.green.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(text, style: TextStyle(fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: isDark ? AppColors.bgLight : Colors.black,
                      )),
                    ),
                  );
                },
              ),
            ),
          ),

          /// -------- LIVE TEXT + MIC --------
          Obx(() {
            if (controller.isRecording.value) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Obx(
                      () => Text(
                        controller.recognizedText.value,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: isDark ? AppColors.bgLight : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text("Listening... 🎤"),
                  SizedBox(height: 20.h),
                ],
              );
            }

            return Padding(
              padding: const EdgeInsets.all(20),
              child: InkWell(
                onTap: () => controller.startRecording(),
                child: CircleAvatar(
                  radius: 35.r,
                  backgroundColor: Colors.redAccent,
                  child: Icon(Icons.mic, color: Colors.white, size: 32.sp),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
