import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ServeyController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  ///Servey Language learn..........
  RxString selectedLearnLanguage = 'English (British)'.obs;
  void selectLearnLanguage(String language) {
    selectedLearnLanguage.value = language;
  }
  ///Servey Language..........
  RxString selectedLanguage = 'English (British)'.obs;
  void selectLanguage(String language) {
    selectedLanguage.value = language;
  }
  /// 0 -> Beginner, 1 -> Intermediate, 2 -> Advanced
  RxInt selectedSkill = (-1).obs;
  void selectSkill(int index) {
    selectedSkill.value = index;
  }
  /// Servey skill improve...........
  RxList<int> selectedImproveSkills = <int>[].obs;
  void toggleImproveSkill(int index) {
    if (selectedImproveSkills.contains(index)) {
      selectedImproveSkills.remove(index);
    } else {
      selectedImproveSkills.add(index);
    }
  }
  /// times.............
  RxInt selectedTime = (-1).obs;
  void selectTimes(int index) {
    selectedTime.value = index;
  }
  /// works....................
  RxInt selectedWork = (-1).obs;
  void selectWork(int index) {
    selectedWork.value = index;
  }
  /// Reminder ................
  RxList<int> selectedDays = <int>[].obs;
  RxInt selectedHour = 5.obs;
  RxInt selectedMinute = 48.obs;
  RxString selectedPeriod = "PM".obs;
  void toggleDay(int index) {
    if (selectedDays.contains(index)) {
      selectedDays.remove(index);
    } else {
      selectedDays.add(index);
    }
  }
  void setHour(int v) => selectedHour.value = v;
  void setMinute(int v) => selectedMinute.value = v;
  void setPeriod(String period) => selectedPeriod.value = period;
  /// label....................
  RxInt selectedLabel = (-1).obs;
  void selectlabel(int index) {
    selectedLabel.value = index;
  }
}