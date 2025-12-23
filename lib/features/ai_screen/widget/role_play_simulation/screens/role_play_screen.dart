
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../component/custom_widgets/custom_button.dart';
import '../../../../../component/custom_widgets/custom_text_field.dart';
import '../../../../../core/app_colours.dart';
import '../../../../../core/app_images.dart';
import '../controller/role_play_controller.dart';

class RolePlayScreen extends StatelessWidget {
  final RolePlayController controller = Get.put(RolePlayController());
  RolePlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
        elevation: 0,
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

            /// Chat Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundImage: AssetImage(AppImages.pakhi1),
                ),
                SizedBox(width: 15.w),

                /// Chat Bubble
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.btnBG,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ano pangalan mo",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "What's your name?",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: isDark ? Colors.white70 : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 25.h),

            /// Buttons Row
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: "Voice",
                    suffixIcon: Icon(Icons.mic_none_rounded, color: Colors.white),
                    onTap: () {
                      controller.showVoiceFieldValue();
                    },
                    backgroundColor: AppColors.btnBG,
                    borderColor: Colors.transparent,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: CustomButton(
                    text: "Typing",
                    suffixIcon: Icon(Icons.send_sharp, color: Colors.white),
                    onTap: () {
                      controller.showTextFieldValue();
                    },
                    backgroundColor: AppColors.lightText,
                    borderColor: Colors.transparent,
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.h),

            /// Text Input Field (for Typing)
            Obx(() {
              return controller.showTextField.value
                  ? CustomTextField(
                textEditingController: controller.typeController,
                hintText: "Type your response here...",
                maxLines: 4,
                hintTextColor: isDark ? AppColors.bgLight : Colors.black54,
                fillColor: Colors.transparent,
                textColor: isDark ? AppColors.bgLight : Colors.black,
                borderSide: BorderSide(
                  color: isDark ? AppColors.btnTextBule : Colors.black,
                  width: 1.w,
                ),
              )
                  : SizedBox.shrink();
            }),

            /// Voice Input Field (with Waveform Animation)
            Obx(() {
              return controller.showVoiceField.value
                  ? Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isDark ? AppColors.btnTextBule : Colors.black,
                    width: 1.w,
                  ),
                ),
                child: Column(
                  children: [
                    /// Microphone with Glow Animation
                    Obx(() {
                      return AvatarGlow(
                        animate: controller.isListening.value,
                        glowColor: AppColors.btnBG,
                        duration: Duration(milliseconds: 2000),
                        repeat: true,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.btnBG,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            controller.isListening.value
                                ? Icons.mic
                                : Icons.mic_none,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      );
                    }),

                    SizedBox(height: 20.h),

                    /// Listening Status
                    Obx(() {
                      return Text(
                        controller.isListening.value
                            ? "Listening..."
                            : "Tap to speak",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      );
                    }),

                    SizedBox(height: 15.h),

                    /// Waveform (Simple bars animation)
                    Obx(() {
                      return controller.isListening.value
                          ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            width: 4.w,
                            height: controller.soundLevel.value > 0
                                ? (20 + (index * 10) * controller.soundLevel.value).h
                                : (20 + (index * 5)).h,
                            decoration: BoxDecoration(
                              color: AppColors.btnBG,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          );
                        }),
                      )
                          : SizedBox.shrink();
                    }),

                    SizedBox(height: 20.h),

                    /// Recognized Text Display
                    Obx(() {
                      return controller.voiceText.value.isNotEmpty
                          ? Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.grey[800]
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          controller.voiceText.value,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      )
                          : SizedBox.shrink();
                    }),

                    SizedBox(height: 15.h),

                    /// Stop/Start Button
                    Obx(() {
                      return controller.isListening.value
                          ? ElevatedButton.icon(
                        onPressed: () {
                          controller.stopListening();
                        },
                        icon: Icon(Icons.stop),
                        label: Text("Stop"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                      )
                          : ElevatedButton.icon(
                        onPressed: () {
                          controller.startListening();
                        },
                        icon: Icon(Icons.mic),
                        label: Text("Start Recording"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.btnBG,
                          foregroundColor: Colors.white,
                        ),
                      );
                    }),
                  ],
                ),
              )
                  : SizedBox.shrink();
            }),

            SizedBox(height: 25.h),

            /// Submit Button
            CustomButton(
              text: "Submit response",
              onTap: () {
                // Handle submission
                if (controller.showTextField.value) {
                  String response = controller.typeController.text;
                  if (response.isNotEmpty) {
                    print("Typed Response: $response");
                    // Add your submission logic here
                  } else {
                    Get.snackbar(
                      'Error',
                      'Please type your response',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                } else if (controller.showVoiceField.value) {
                  String response = controller.voiceText.value;
                  if (response.isNotEmpty) {
                    print("Voice Response: $response");
                    // Add your submission logic here
                  } else {
                    Get.snackbar(
                      'Error',
                      'Please record your voice response',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                } else {
                  Get.snackbar(
                    'Error',
                    'Please select Voice or Typing mode',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
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