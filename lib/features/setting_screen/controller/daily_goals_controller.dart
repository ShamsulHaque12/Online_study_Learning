import 'package:get/get.dart';

import '../model/goals_model.dart';

class DailyGoalsController extends GetxController {
  RxList<GoalsModel> routines = <GoalsModel>[
    GoalsModel(title: "Relaxed", duration: "5 mins/day"),
    GoalsModel(title: "Comfortable", duration: "10 mins/day"),
    GoalsModel(title: "Effective", duration: "20 mins/day"),
    GoalsModel(title: "Intense", duration: "30 mins/day"),
  ].obs;

  RxList<bool> selected = List.generate(4, (index) => false).obs;

  void toggleCheck(int index) {
    selected[index] = !selected[index];
  }

  RxBool isReminderOn = false.obs;

  void toggleReminder(bool value) {
    isReminderOn.value = value;
  }

  RxInt selectedHour = 5.obs;
  RxInt selectedMinute = 48.obs;
  RxString selectedPeriod = "PM".obs;

  List<int> hours = List.generate(12, (i) => i + 1);
  List<int> minutes = List.generate(60, (i) => i);
  List<String> periods = ["AM", "PM"];
}
