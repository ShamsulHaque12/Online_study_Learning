
import 'package:get/get.dart';
import 'package:online_study/services/api_endpoints.dart';
import 'package:online_study/services/network_caller.dart';
import '../model/mastery_model.dart';
import 'package:logger/logger.dart';

class MasteryController extends GetxController {
  RxDouble progress = 0.5.obs;
  RxDouble circleProgress = 0.7.obs;
  RxInt pointsToNextChapter = 100.obs;
  var progressLesson = 40.obs;
  final isLoading = false.obs;

  /// Sections
  var sections = <Section>[].obs;

  /// 🔹 Fetch Mastery Data
  Future<void> getMasteryData() async {
    try {
      isLoading.value = true;
      final response = await NetworkCaller().getRequest(
        url: ApiEndpoints.mastryLevel,
      );

      if (response.isSuccess && response.responseData != null) {
        final mastery = MasteryModel.fromJson(response.responseData!);

        progress.value = (mastery.data?.chapter?.progressPercent ?? 0) / 100;
        circleProgress.value =
            (mastery.data?.overallProgressPercent ?? 0) / 100;
        pointsToNextChapter.value =
            mastery.data?.chapter?.pointsToNextChapter ?? 100;

        sections.assignAll(mastery.data?.sections ?? []);
      } else {
        Logger().e(response.errorMessage);
      }
    } catch (e) {
      Logger().e(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void updateProgressLesson(int value) {
    progressLesson.value = value;
  }
}
