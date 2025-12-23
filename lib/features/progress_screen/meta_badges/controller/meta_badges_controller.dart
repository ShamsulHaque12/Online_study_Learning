import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class MetaBadgesController extends GetxController {
  final int totalTiers = 5;

  RxInt unlockedTier = 1.obs;

  List<int> totalTasksPerTier = [3, 4, 5, 4, 3];
  RxList<int> completedTasks = <int>[0, 0, 0, 0, 0].obs;

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