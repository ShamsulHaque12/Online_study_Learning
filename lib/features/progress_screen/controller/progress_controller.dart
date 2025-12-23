import 'package:get/get.dart';

class ProgressController extends GetxController {
  /// Tab Bar............
  RxInt selectedTab = 0.obs;
  void changeTab(int index) {
    selectedTab.value = index;
  }
  /// Tab Bar............
  RxInt selectedAchive = 0.obs;
  void changeAchive(int index) {
    selectedAchive.value = index;
  }


}
