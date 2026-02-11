
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:online_study/features/profile_screen/model/weekly_progress.dart';
import 'package:online_study/services/api_endpoints.dart';
import 'package:online_study/services/network_caller.dart';

class ProfileController extends GetxController {
  final isDailyPointsLoading = false.obs;
  final dailyPoints = <DailyPointData>[].obs;

  final logger = Logger();

  @override
  void onInit() {
    super.onInit();
    getDailyPoint();
  }

  /// Fetch daily points from API
  Future<void> getDailyPoint() async {
    try {
      isDailyPointsLoading.value = true;
      final response = await NetworkCaller().getRequest(
        url: ApiEndpoints.dailyPoint,
      );

      if (response.isSuccess) {
        final model = WeeklyProgress.fromJson(response.responseData!);
        // Fill last 7 days with 0 if missing
        final filled = _fillLast7Days(model.data);
        dailyPoints.assignAll(filled);
        logger.i('DailyPoints Loaded');
      }
    } catch (e) {
      logger.e('DailyPoint Error: $e');
    } finally {
      isDailyPointsLoading.value = false;
    }
  }

  /// Fill last 7 days (today included), 0 points if missing
  List<DailyPointData> _fillLast7Days(List<DailyPointData> data) {
    final today = DateTime.now();
    final last7Days = List.generate(
        7, (i) => today.subtract(Duration(days: 6 - i))); // 7 days

    return last7Days.map((day) {
      final match = data.firstWhere(
        (d) {
          final dDate = DateTime.tryParse(d.date);
          return dDate != null &&
              dDate.year == day.year &&
              dDate.month == day.month &&
              dDate.day == day.day;
        },
        orElse: () => DailyPointData(date: day.toIso8601String(), points: 0),
      );

      return DailyPointData(date: day.toIso8601String(), points: match.points);
    }).toList();
  }

  /// Safe daily points for chart
  List<DailyPointData> get safeDailyPoints => dailyPoints;

  /// Total weekly points
  int get totalWeeklyPoints =>
      safeDailyPoints.fold(0, (sum, item) => sum + item.points);

  /// FlSpot list for LineChart
  List<FlSpot> get weeklyPointSpots {
    return List.generate(
      safeDailyPoints.length,
      (index) => FlSpot(
        index.toDouble(),
        safeDailyPoints[index].points.toDouble(),
      ),
    );
  }

  /// Bottom titles for chart (day number)
  String chartLabel(int index) {
    if (index < 0 || index >= safeDailyPoints.length) return '';
    final date = DateTime.tryParse(safeDailyPoints[index].date);
    if (date == null) return '';
    return "${date.day}";
  }
}
