import 'package:get/get.dart';
import 'package:online_study/features/challenges/controller/challengers_controller.dart';

class ChallengesBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ChallengersController>(()=>ChallengersController());
  }
}