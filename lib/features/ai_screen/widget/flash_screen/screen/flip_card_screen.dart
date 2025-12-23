import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import '../controller/flip_card_controller.dart';

class FlipCardScreen extends StatelessWidget {
  FlipCardScreen({Key? key}) : super(key: key);

  final FlipCardController controller = Get.put(FlipCardController());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDark ? Colors.grey[900] : Colors.grey[50],
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          'Practice',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildProgressBar(isDark),
          SizedBox(height: 10.h),
          _buildQuestionText(isDark),
          SizedBox(height: 30.h),
          Expanded(child: _buildFlipCard(isDark)),
          _buildNavigationButtons(),
          _buildActionButtons(isDark),
          _buildFeedbackSection(),
        ],
      ),
    );
  }

  Widget _buildProgressBar(bool isDark) {
    return Obx(() => Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${controller.currentIndex.value + 1} of ${controller.quizCards.length}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          LinearProgressIndicator(
            value: controller.progress,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            minHeight: 8.h,
            borderRadius: BorderRadius.circular(10.r),
          ),
        ],
      ),
    ));
  }

  Widget _buildQuestionText(bool isDark) {
    return Obx(() => Text(
      controller.currentCard.question,
      style: TextStyle(
        fontSize: 18.sp,
        color: isDark ? Colors.white : Colors.black87,
      ),
    ));
  }

  Widget _buildFlipCard(bool isDark) {
    return Obx(() {
      return TweenAnimationBuilder<double>(
        tween: Tween<double>(
          begin: 0,
          end: controller.isFlipped.value ? 1 : 0,
        ),
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        builder: (context, value, child) {
          final angle = value * math.pi;
          final isBack = angle > math.pi / 2;

          return GestureDetector(
            onTap: controller.toggleFlip,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(angle),
              child: isBack
                  ? Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..rotateY(math.pi),
                child: _buildBackCard(isDark),
              )
                  : _buildFrontCard(isDark),
            ),
          );
        },
      );
    });
  }

  Widget _buildFrontCard(bool isDark) {
    return Obx(() {
      final card = controller.currentCard;
      return Center(
        child: Stack(
          children: [
            // Background Card
            Positioned(
              left: 30.w,
              right: 30.w,
              top: 40.h,
              bottom: 40.h,
              child: Transform.rotate(
                angle: -0.05,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ),
            ),
            // Main Card
            Center(
              child: Container(
                width: 250.w,
                height: 250.h,
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      card.word,
                      style: TextStyle(
                        fontSize: 36.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      card.pronunciation,
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.orange.shade700,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Text(
                      'Tap to flip',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.orange.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildBackCard(bool isDark) {
    return Obx(() {
      final card = controller.currentCard;
      return Center(
        child: Stack(
          children: [
            // Background Card
            Positioned(
              left: 30.w,
              right: 30.w,
              top: 40.h,
              bottom: 40.h,
              child: Transform.rotate(
                angle: 0.05,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ),
            ),
            // Main Card
            Center(
              child: Container(
                width: 250.w,
                height: 250.h,
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      card.meaning,
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30.h),
                    Text(
                      'Tap to flip back',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.orange.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildNavigationButtons() {
    return Obx(() => Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: controller.currentIndex.value > 0
                ? controller.previousCard
                : null,
            icon: Icon(
              Icons.arrow_back,
              size: 32.sp,
              color: controller.currentIndex.value > 0
                  ? Colors.orange
                  : Colors.grey.shade400,
            ),
          ),
          IconButton(
            onPressed: controller.currentIndex.value <
                controller.quizCards.length - 1
                ? controller.nextCard
                : null,
            icon: Icon(
              Icons.arrow_forward,
              size: 32.sp,
              color: controller.currentIndex.value <
                  controller.quizCards.length - 1
                  ? Colors.orange
                  : Colors.grey.shade400,
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildActionButtons(bool isDark) {
    return SafeArea(
      child: Obx(() => Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Bookmark
            IconButton(
              onPressed: controller.toggleBookmark,
              icon: Icon(
                controller.isBookmarked()
                    ? Icons.bookmark
                    : Icons.bookmark_border,
                size: 32.sp,
                color: controller.isBookmarked()
                    ? Colors.orange
                    : (isDark ? Colors.white : Colors.black),
              ),
            ),
            // Mic
            IconButton(
              onPressed: controller.isListening.value
                  ? controller.stopListening
                  : controller.startListening,
              icon: Icon(
                controller.isListening.value ? Icons.mic : Icons.mic_none,
                size: 32.sp,
                color: controller.isListening.value
                    ? Colors.red
                    : (isDark ? Colors.white : Colors.black),
              ),
            ),
            // Sound
            IconButton(
              onPressed: controller.speakText,
              icon: Icon(
                Icons.volume_up,
                size: 32.sp,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget _buildFeedbackSection() {
    return Obx(() {
      if (controller.isListening.value) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.red.shade100,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.mic, color: Colors.red, size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                'Listening...',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.red.shade900,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }

      if (controller.spokenText.value.isNotEmpty) {
        final isCorrect = controller.isAnswerCorrect();
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isCorrect ? Colors.green.shade100 : Colors.blue.shade100,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color:
              isCorrect ? Colors.green.shade400 : Colors.blue.shade400,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Icon(
                isCorrect ? Icons.check_circle : Icons.mic,
                color: isCorrect ? Colors.green.shade700 : Colors.blue.shade700,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'You said: "${controller.spokenText.value}"',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: isCorrect
                        ? Colors.green.shade900
                        : Colors.blue.shade900,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      }

      return SizedBox.shrink();
    });
  }
}