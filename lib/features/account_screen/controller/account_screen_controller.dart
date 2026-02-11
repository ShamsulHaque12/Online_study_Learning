
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/global/widgets/error_toast_message.dart';
import 'package:online_study/global/widgets/success_snakbar.dart';
import 'package:online_study/route/app_routes.dart';
import 'package:online_study/services/api_endpoints.dart';
import 'package:online_study/services/network_caller.dart';
import 'package:online_study/services/shared_preferences_helper.dart';

class AccountScreenController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoginLoading = false.obs;
  final isLoading = false.obs;
  final Logger logger = Logger();

  Future<void> loginUser(BuildContext context) async {
    isLoginLoading.value = true;

    try {
      final response = await NetworkCaller().postRequest(
        url: ApiEndpoints.login,
        body: {
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        },
      );

      logger.w("LOGIN RESPONSE => ${response.responseData}");

      if (response.isSuccess == true &&
          response.responseData != null &&
          response.responseData!['data'] != null) {
        final data = response.responseData!['data'];

        /// ✅ Save Access Token (null safe)
        if (data['accessToken'] != null &&
            data['accessToken'].toString().isNotEmpty) {
          await SharedPreferencesHelper.saveAccessToken(
            data['accessToken'].toString(),
          );
        } else {
          ErrorToastMessage.show("Access token not found");
          return;
        }

        /// ✅ Save Language (null safe)
        final language = data['preferedLanguage'] ?? 'en';
        Get.find<LanguageController>().saveLanguage(language.toString());

        /// ✅ Success message
        SuccessSnackBar.show(
          context,
          response.responseData?['message'] ?? "Login Successful",
        );

        /// ✅ Navigate
        Get.offAllNamed(AppRoutes.bottomNavScreen);
      } else {
        ErrorToastMessage.show(
          response.responseData?['message'] ??
              response.errorMessage ??
              "Login failed",
        );
      }
    } catch (e) {
      logger.e("LOGIN ERROR => $e");
      ErrorToastMessage.show("Error logging in. Please try again.");
    } finally {
      isLoginLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
