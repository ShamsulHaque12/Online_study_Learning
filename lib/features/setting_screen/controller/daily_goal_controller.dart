import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:online_study/features/setting_screen/model/goal_model.dart';

class DailyGoalController extends GetxController {
  RxList<GoalModel> routines = <GoalModel>[
    GoalModel(title: "Relaxed", duration: "5 mins/day"),
    GoalModel(title: "Comfortable", duration: "10 mins/day"),
    GoalModel(title: "Effective", duration: "20 mins/day"),
    GoalModel(title: "Intense", duration: "30 mins/day"),
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
