import 'package:get/get.dart';

class Streakcontroller extends GetxController {
  /// Calendar................
  Rx<DateTime> focusedDay = DateTime.now().obs;
  Rx<DateTime?> selectedDay = Rx<DateTime?>(null);
  void selectDay(DateTime day) {
    selectedDay.value = day;
    focusedDay.value = day;
  }
  /// progress bar.......
  RxDouble progress = 0.3.obs;
  void updateProgress(double value) {
    if (value >= 0.0 && value <= 1.0) {
      progress.value = value;
    }
  }
}
