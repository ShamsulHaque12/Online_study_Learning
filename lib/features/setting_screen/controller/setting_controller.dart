import 'package:get/get.dart';

class SettingController extends GetxController {

  RxBool notificationsEnabled = true.obs;
  RxBool rankingEnabled = true.obs;

  void toggleNotifications(bool value) => notificationsEnabled.value = value;
  void toggleRanking(bool value) => rankingEnabled.value = value;
}