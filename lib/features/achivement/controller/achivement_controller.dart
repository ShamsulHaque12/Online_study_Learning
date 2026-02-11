
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:online_study/features/achivement/model/achivement_model.dart';
import 'package:online_study/services/api_endpoints.dart';
import 'package:online_study/services/network_caller.dart';

class AchivementController extends GetxController {
  /// Tab Bar
  RxInt selectedAchive = 0.obs;
  void changeAchive(int index) => selectedAchive.value = index;

  /// Loading
  final isLoading = false.obs;

  /// Master Achivement Model
  AchivementModel? achivementModel;

  /// Separate lists for screens
  RxList<BadgeTiers> badgeTiersList = <BadgeTiers>[].obs;
  RxList<LevelSystem> levelSystemList = <LevelSystem>[].obs;
  RxList<MetaBadges> metaBadgesList = <MetaBadges>[].obs;

  /// Fetch Achivement Data
  Future<void> fetchAchivementData() async {
    try {
      isLoading.value = true;

      final response = await NetworkCaller().getRequest(
        url: ApiEndpoints.achivement,
      );

      if (response.isSuccess && response.responseData != null) {
        Logger().i(response.responseData);

        // Parse model
        achivementModel = AchivementModel.fromJson(response.responseData!);

        // Populate separate lists safely
        badgeTiersList.value = achivementModel?.data?.tabs?.badgeTiers ?? [];
        levelSystemList.value = achivementModel?.data?.tabs?.levelSystem ?? [];
        metaBadgesList.value = achivementModel?.data?.tabs?.metaBadges ?? [];

      } else {
        Logger().e(response.errorMessage);
      }
    } catch (e) {
      Logger().e(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
