
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:online_study/features/leader_board/model/friends_model.dart';
import 'package:online_study/services/api_endpoints.dart';
import 'package:online_study/services/network_caller.dart';

class LeaderBoardController extends GetxController {
  /// Tab Bar
  RxInt selectedTab = 0.obs;
  void changeTab(int index) {
    selectedTab.value = index;
  }
  final isLoading = false.obs;

  /// Friends list from API
  final friends = <FriendData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFriends();
  }

  /// Fetch Friends from API
  Future<void> fetchFriends() async {
    try {
      isLoading.value = true;
      final response = await NetworkCaller().getRequest(
        url: ApiEndpoints.lederBoard,
      );

      if (response.isSuccess && response.responseData != null) {
        final model = FriendsModel.fromJson(response.responseData!);

        // Assign to reactive list
        friends.assignAll(model.data ?? []);

        Logger().i('Friends Loaded: ${friends.length}');
      } else {
        Logger().e(response.errorMessage);
      }
    } catch (e) {
      Logger().e('Fetch Friends Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
