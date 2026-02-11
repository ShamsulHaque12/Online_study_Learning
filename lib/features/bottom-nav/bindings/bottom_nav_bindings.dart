import 'package:get/instance_manager.dart';
import 'package:online_study/features/bottom-nav/controller/bottom_nav_controller.dart';

class BottomNavBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavController>(() => BottomNavController());
  }
}
