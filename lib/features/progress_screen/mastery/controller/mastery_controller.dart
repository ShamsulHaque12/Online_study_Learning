import 'package:get/get.dart';

class MasteryController extends GetxController {
  /// progress bar.......
  RxDouble progress = 0.5.obs;
  void updateProgress(double value) {
    if (value >= 0.0 && value <= 1.0) {
      progress.value = value;
    }
  }
  /// Circle Progress Bar........
  RxDouble circleProgress = 0.7.obs;
  void updateCircleProgress(double value) {
    if (value >= 0.0 && value <= 1.0) {
      circleProgress.value = value;
    }
  }
}