import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessSnackBar {
  static void show(BuildContext context, String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.TOP,
      snackStyle: SnackStyle.FLOATING,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        left: 10,
        right: 10,
      ),
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}