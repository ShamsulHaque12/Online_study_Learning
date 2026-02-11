import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class OtpController extends GetxController {
final pinController = TextEditingController();
  var seconds = 30.obs;
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

  void resendCode() {
    // Logic to resend the OTP code
    seconds.value = 30;
    startTimer();
  }

  @override
  void onClose() {
    pinController.dispose();
    _timer?.cancel();
    super.onClose();
  }
}
