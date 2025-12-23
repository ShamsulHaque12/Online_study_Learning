import 'package:get/get.dart';

class TierDetailsController extends GetxController {
  final int totalTiers = 7;

  RxInt unlockedTier = 1.obs;

  List<int> totalTasksPerTier = [3, 4, 5, 4, 3, 5, 4];
  RxList<int> completedTasks = <int>[0, 0, 0, 0, 0, 0, 0].obs;

  void completeTask(int tierIndex) {
    if (completedTasks[tierIndex] < totalTasksPerTier[tierIndex]) {
      completedTasks[tierIndex]++;

      if (completedTasks[tierIndex] == totalTasksPerTier[tierIndex]) {
        unlockNextTier(tierIndex);
      }
    }
  }

  void unlockNextTier(int tierIndex) {
    if (tierIndex + 1 < totalTiers) {
      unlockedTier.value = tierIndex + 2;
    }
  }

  bool isUnlocked(int index) {
    return (index + 1) <= unlockedTier.value;
  }
}