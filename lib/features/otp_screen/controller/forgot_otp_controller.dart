import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:online_study/features/account_screen/screen/new_forgot_password_screen.dart';
import 'package:online_study/global/widgets/error_toast_message.dart';
import 'package:online_study/global/widgets/success_snakbar.dart';
import 'package:online_study/services/api_endpoints.dart';
import 'package:online_study/services/network_caller.dart';

class ForgotOtpController extends GetxController {
  final pinController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var seconds = 120.obs;
  final isLoading = false.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds.value > 0) {
        seconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void resendCode(BuildContext context, String userID) async {
    // Logic to resend the OTP code
    seconds.value = 120;
    await resendOTP(context, userID);
  }

  Future<void> verifyOtp(BuildContext context, String userID) async {
    final networkCaller = NetworkCaller();
    try {
      isLoading.value = true;
      final response = await networkCaller.postRequest(
        url: ApiEndpoints.verifyEmail,
        body: {'userId': userID, 'otpCode': pinController.text.trim()},
      );
      if (response.isSuccess) {
        SuccessSnackBar.show(context, "OTP verified successfully");
        Logger().i(response.responseData);
        Get.offAll(
          () => NewForgotPasswordScreen(),
          arguments: {
            'accessToken': response.responseData?['data']['accessToken'],
          },
        );
      } else {
        ErrorToastMessage.show(response.errorMessage);
        Logger().e(response.responseData);
      }
    } catch (e) {
      ErrorToastMessage.show('Failed to verify OTP.');

      Logger().e(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendOTP(BuildContext context, String userID) async {
    final networkCaller = NetworkCaller();
    try {
      final response = await networkCaller.postRequest(
        url: ApiEndpoints.resendOTP,
        body: {'userId': userID},
      );
      if (response.isSuccess) {
        SuccessSnackBar.show(context, "OTP resent successfully");
        Logger().i(response.responseData);
        seconds.value = 120;
        startTimer();
      } else {
        ErrorToastMessage.show(response.errorMessage);
        Logger().e(response.responseData);
      }
    } catch (e) {
      ErrorToastMessage.show('Failed to resend OTP.');
      Logger().e(e.toString());
    }
  }

  @override
  void onClose() {
    pinController.dispose();
    _timer?.cancel();
    super.onClose();
  }
}
