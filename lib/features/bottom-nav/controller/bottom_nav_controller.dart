import 'package:get/state_manager.dart';

class BottomNavController extends GetxController{

  var currentIndex = 2.obs; // Start with Home (index 2)
  
  void changeIndex(int index) {
    currentIndex.value = index;
  }
}