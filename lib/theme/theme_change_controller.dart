import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _box = GetStorage();
  static const _key = 'isDark';

  RxBool isDark = false.obs;

  ThemeMode get themeMode => isDark.value ? ThemeMode.dark : ThemeMode.light;

  @override
  void onInit() {
    super.onInit();
    isDark.value = _box.read(_key) ?? false;
  }

  void toggleTheme() {
    isDark.toggle();
    _box.write(_key, isDark.value);

    Get.changeThemeMode(themeMode);
  }
}
