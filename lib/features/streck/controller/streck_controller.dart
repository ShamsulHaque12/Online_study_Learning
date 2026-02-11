
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:online_study/services/api_endpoints.dart';
import 'package:online_study/services/network_caller.dart';
import '../model/steck_model.dart';

class StreckController extends GetxController {
  Rx<DateTime> focusedDay = DateTime.now().obs;
  Rx<DateTime?> selectedDay = Rx<DateTime?>(null);
  final isLoading = false.obs;

  final steckData = Rxn<SteckModel>();

  final fireDays = <int>[].obs;
  RxDouble progress = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    getSteckData();
  }

  /// 🔹 Fetch Steck Data
  Future<void> getSteckData() async {
    try {
      isLoading.value = true;
      final response = await NetworkCaller().getRequest(
        url: ApiEndpoints.steckerPack,
      );

      if (response.isSuccess && response.responseData != null) {
        steckData.value = SteckModel.fromJson(response.responseData!);

        // 🔹 Assign Fire days from API
        fireDays.assignAll(
            steckData.value?.data?.calendar?.activeDays ?? []);

        // 🔹 Progress
        progress.value =
            ((steckData.value?.data?.progressPercent ?? 0) / 100)
                .clamp(0.0, 1.0);

        Logger().i('Steck Data Loaded');
      } else {
        Logger().e(response.errorMessage);
      }
    } catch (e) {
      Logger().e(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Progress bar updater
  void updateProgress(double value) {
    progress.value = value.clamp(0.0, 1.0);
  }

  /// Calendar handlers
  void onDaySelected(DateTime selected, DateTime focused) {
    selectedDay.value = selected;
    focusedDay.value = focused;
  }

  void onPageChanged(DateTime focused) {
    focusedDay.value = focused;
  }

  /// Calendar checkers
  bool isFire(DateTime day) {
    final calendar = steckData.value?.data?.calendar;
    if (calendar == null) return false;
    // Fire only if same month & year
    return day.year == (calendar.year ?? day.year) &&
        day.month == (calendar.month ?? day.month) &&
        fireDays.contains(day.day);
  }

  bool isWater(DateTime day) {
    final today = DateTime.now();
    return day.year == today.year &&
        day.month == today.month &&
        day.day == today.day;
  }

  /// Safe getters for UI
  int get currentStreak => steckData.value?.data?.currentStreak ?? 0;
  int get longestStreak => steckData.value?.data?.longestStreak ?? 0;
  String get lastActivity =>
      steckData.value?.data?.lastActivityDate ?? "—";
  int get target => steckData.value?.data?.target ?? 0;
}
