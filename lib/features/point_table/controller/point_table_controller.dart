
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:online_study/features/point_table/model/daily_point.dart';
import 'package:online_study/features/point_table/model/point_history.dart';
import 'package:online_study/features/point_table/model/point_summary.dart';
import 'package:online_study/services/api_endpoints.dart';
import 'package:online_study/services/network_caller.dart';

class PointTableController extends GetxController {
  final isLoading = false.obs;

  /// Data holders
  final pointSummary = Rxn<PointSummary>();
  final dailyPoints = <DailyPointData>[].obs;
  final pointHistory = <PointHistoryItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllPointData();
  }

  /// Call all APIs together
  Future<void> getAllPointData() async {
    await Future.wait([getPointSummary(), getDailyPoint(), getPointHistory()]);
  }

  /// ---------------- Point Summary ----------------
  Future<void> getPointSummary() async {
    try {
      isLoading.value = true;

      final response = await NetworkCaller().getRequest(
        url: ApiEndpoints.pointSummary,
      );

      if (response.isSuccess) {
        pointSummary.value = PointSummary.fromJson(response.responseData!);

        Logger().i('PointSummary Loaded');
      }
    } catch (e) {
      Logger().e('PointSummary Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// ---------------- Daily Point ----------------
  Future<void> getDailyPoint() async {
    try {
      isLoading.value = true;

      final response = await NetworkCaller().getRequest(
        url: ApiEndpoints.dailyPoint,
      );

      if (response.isSuccess) {
        final dailyPointModel = DailyPoint.fromJson(response.responseData!);

        dailyPoints.assignAll(dailyPointModel.data ?? []);

        Logger().i('DailyPoints Loaded');
      }
    } catch (e) {
      Logger().e('DailyPoint Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// ---------------- Point History ----------------
  Future<void> getPointHistory() async {
    try {
      isLoading.value = true;

      final response = await NetworkCaller().getRequest(
        url: ApiEndpoints.pointHistory,
      );

      if (response.isSuccess) {
        final historyModel = PointHistory.fromJson(response.responseData!);

        pointHistory.assignAll(historyModel.data ?? []);

        Logger().i('PointHistory Loaded');
      }
    } catch (e) {
      Logger().e('PointHistory Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// ---------------- Point History ----------------
  /// 🔹 Total Weekly Points
  List<DailyPointData> get safeDailyPoints {
    if (dailyPoints.isEmpty) {
      return List.generate(7, (index) => DailyPointData(date: '', points: 0));
    }

    return dailyPoints;
  }

  int get totalWeeklyPoints {
    return safeDailyPoints.fold(0, (sum, item) => sum + (item.points ?? 0));
  }

  List<FlSpot> get weeklyPointSpots {
    return List.generate(
      safeDailyPoints.length,
      (index) => FlSpot(
        index.toDouble(),
        (safeDailyPoints[index].points ?? 0).toDouble(),
      ),
    );
  }

  /// ---------------- Point summary ----------------
  /// 🔹 Total (Safe)
  int get totalPoints => pointSummary.value?.data?.totalPoints ?? 0;
  int get totalTimeSec => pointSummary.value?.data?.totalTime ?? 0;
  int get thisWeekPoints => pointSummary.value?.data?.thisWeek?.points ?? 0;
  int get thisWeekTimeSec => pointSummary.value?.data?.thisWeek?.time ?? 0;
  String formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return "${m}m ${s}s";
  }

  /// ---------------- Point History ----------------
  /// 🔹 Always return last 7 history items (safe fallback)
  List<PointHistoryItem> get last7History {
    if (pointHistory.isEmpty) {
      return List.generate(
        7,
        (_) => PointHistoryItem(
          completedAt: null,
          metadata: PointMetadata(
            totalPoints: 0,
            timeTakenSec: 0,
            correctAnswers: 0,
            wrongAnswers: 0,
          ),
        ),
      );
    }

    final items = pointHistory.take(7).toList();

    if (items.length < 7) {
      items.addAll(
        List.generate(
          7 - items.length,
          (_) => PointHistoryItem(
            completedAt: null,
            metadata: PointMetadata(
              totalPoints: 0,
              timeTakenSec: 0,
              correctAnswers: 0,
              wrongAnswers: 0,
            ),
          ),
        ),
      );
    }

    return items;
  }

  /// 🔹 Date formatter
  String formatHistoryDate(String? raw) {
    if (raw == null || raw.isEmpty) return "—";

    final date = DateTime.tryParse(raw);
    if (date == null) return "—";

    return "${_monthName(date.month)} ${date.day}, ${date.year}";
  }

  String _monthName(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return months[month - 1];
  }
}
