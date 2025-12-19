import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final gmailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final pinController = TextEditingController();

  var otpCode = ''.obs;
  final seconds = 60.obs;
  var isLoading = false.obs;
  Timer? timer;
  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    seconds.value = 60;
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (seconds.value > 0) {
        seconds.value--;
      } else {
        t.cancel();
      }
    });
  }
  void onResendCode() {
    startTimer();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }


}