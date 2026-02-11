import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';
import 'package:http/http.dart' as http;
import 'package:online_study/features/otp_screen/screens/forgot_otp_screen.dart';
import 'package:online_study/global/widgets/error_toast_message.dart';
import 'package:online_study/global/widgets/success_snakbar.dart';
import 'package:online_study/route/app_routes.dart';
import 'package:online_study/services/api_endpoints.dart';
import 'package:online_study/services/network_caller.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final logger = Logger();
  final emailSubmitLoading = false.obs;
  final passwordResetLoading = false.obs;

  Future<void> submitForgotPassword(BuildContext context) async {
    final networkCaller = NetworkCaller();
    emailSubmitLoading.value = true;
    try {
      final respose = await networkCaller.postRequest(
        url: ApiEndpoints.forgotPassword,
        body: {"email": emailController.text.trim()},
      );
      if (respose.isSuccess) {
        logger.i("Forgot password request successful");
        logger.d(respose.responseData);
        Get.to(
          () => ForgotOtpScreen(),
          arguments: {"id": respose.responseData?['data']['id']},
        );
      } else {
        logger.e(respose.responseData);
        ErrorToastMessage.show(respose.errorMessage);
      }
    } catch (e) {
      logger.e("Forgot password request failed: $e");
      ErrorToastMessage.show('Failed to submit forgot password request.');
    } finally {
      emailSubmitLoading.value = false;
    }
  }

  Future<void> resetPassword(BuildContext context, String accessToken) async {
    try {
      passwordResetLoading.value = true;
      final response = await http.post(
        Uri.parse(ApiEndpoints.resetPassword),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'newPassword': newPasswordController.text.trim()}),
      );
      Logger().d('Response status: ${response.statusCode}');
      Logger().d('Response body: ${response.body}');
      Logger().d('Used Access Token: $accessToken');

      if (response.statusCode == 200 || response.statusCode == 201) {
        logger.i("Password reset successful");
        SuccessSnackBar.show(context, "Password reset successfully");
        Get.offAllNamed(AppRoutes.welcomeScreen);
      } else {
        logger.e("Password reset failed with status: ${response.statusCode}");
        ErrorToastMessage.show('Failed to reset password.');
      }
    } catch (e) {
      logger.e("Password reset failed: $e");
      ErrorToastMessage.show('Failed to reset password.');
    } finally {
      passwordResetLoading.value = false;
    }
  }
}
