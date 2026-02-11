import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/theme/theme_change_controller.dart';
import '../controller/ai_role_play_talk_controller.dart';

class AiRolePlayTalk extends StatelessWidget {
  AiRolePlayTalk({super.key});

  final controller = Get.put(AiRolePlayTalkController());
  final ScrollController scrollController = ScrollController();
  final langController = Get.find<LanguageController>();

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.isDark.value;

    return Scaffold(
      backgroundColor: isDark ? AppDarkColors.backgroundColor : AppLightColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDark ? AppDarkColors.backgroundColor : AppLightColors.backgroundColor,
        title: Text(
          langController.selectedLanguage["AI Role-Play Talk"] ?? "AI Role-Play Talk",
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios, color: isDark ? Colors.white : Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              WidgetsBinding.instance.addPostFrameCallback((_) => scrollToBottom());

              if (controller.isLoading.value && controller.messages.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              return ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final msg = controller.messages[index];
                  bool isAi = msg['role'] == 'ai';
                  return _buildChatBubble(msg['text'] ?? '', isAi, isDark);
                },
              );
            }),
          ),
          
          // মাইক সেকশন (লিমিট চেকসহ)
          _buildMicSection(isDark),
        ],
      ),
    );
  }

  Widget _buildChatBubble(String text, bool isAi, bool isDark) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: isAi ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isAi) _buildAvatar(Icons.smart_toy, AppLightColors.primaryColor),
          SizedBox(width: 8.w),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isAi 
                    ? (isDark ? Colors.white12 : Colors.blue.shade50)
                    : (isDark ? Colors.orange.shade900 : Colors.orange.shade100),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                text,
                style: GoogleFonts.inter(
                  fontSize: 15.sp,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          if (!isAi) _buildAvatar(Icons.person, Colors.orange),
        ],
      ),
    );
  }

  Widget _buildAvatar(IconData icon, Color color) {
    return CircleAvatar(
      radius: 16.r,
      backgroundColor: color,
      child: Icon(icon, color: Colors.white, size: 16.sp),
    );
  }

  Widget _buildMicSection(bool isDark) {
    return Obx(() {
      // ৫ বার পূর্ণ হলে মাইক্রোফোন ইনভিজিবল হবে
      if (controller.userTalkCount.value >= controller.maxTalkLimit) {
        return Container(
          padding: EdgeInsets.all(20.h),
          child: Text(
            "Conversation limit reached (5/5)",
            style: GoogleFonts.inter(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        );
      }

      bool recording = controller.isRecording.value;
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Column(
          children: [
            GestureDetector(
              onTap: recording 
                ? () => controller.stopRecording(Get.context!) 
                : () => controller.startRecording(),
              child: CircleAvatar(
                radius: 35.r,
                backgroundColor: recording ? Colors.red : AppDarkColors.primaryColor,
                child: Icon(recording ? Icons.stop : Icons.mic, color: Colors.white, size: 35.sp),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Talks: ${controller.userTalkCount.value}/5",
              style: GoogleFonts.inter(color: isDark ? Colors.white70 : Colors.black54),
            ),
          ],
        ),
      );
    });
  }
}