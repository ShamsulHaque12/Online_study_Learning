import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  RxBool notificationsEnabled = true.obs;
  final bool rankingEnabled = true; // এখন এটি fixed true
  RxBool darkModeEnabled = false.obs;

  void toggleNotifications(bool value) => notificationsEnabled.value = value;

  // rankingEnabled toggle function আর দরকার নেই
  // void toggleRanking(bool value) => rankingEnabled.value = value;

  void toggleDarkMode(bool value) {
    darkModeEnabled.value = value;
    if (value) {
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      Get.changeThemeMode(ThemeMode.light);
    }
  }
}
