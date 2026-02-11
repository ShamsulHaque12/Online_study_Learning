
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:online_study/features/peer_screens/model/follower_model.dart';
import 'package:online_study/features/peer_screens/model/following_model.dart';
import 'package:online_study/services/api_endpoints.dart';
import 'package:online_study/services/network_caller.dart';

class FollowerController extends GetxController {
  var isLoading = false.obs;

  // Reactive list for followers
  var followers = <FollowerData>[].obs;

  // Reactive list for following
  var following = <FollowingData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFollowerList();
    fetchFollowingList();
  }

  /// Fetch follower list from API
  Future<void> fetchFollowerList() async {
    try {
      isLoading.value = true;

      final response = await NetworkCaller().getRequest(
        url: ApiEndpoints.follower,
      );

      if (response.isSuccess && response.responseData != null) {
        FollowerModel followerModel = FollowerModel.fromJson(response.responseData!);
        followers.value = followerModel.data ?? [];
      } else {
        followers.clear();
        Logger().e('Failed to fetch followers: ${response.errorMessage}');
      }
    } catch (e) {
      Logger().e('Error fetching followers: $e');
      followers.clear();
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetch following list from API
  Future<void> fetchFollowingList() async {
    try {
      isLoading.value = true;

      final response = await NetworkCaller().getRequest(
        url: ApiEndpoints.following,
      );

      if (response.isSuccess && response.responseData != null) {
        FollowingModel followingModel = FollowingModel.fromJson(response.responseData!);
        following.value = followingModel.data ?? [];
      } else {
        following.clear();
        Logger().e('Failed to fetch following: ${response.errorMessage}');
      }
    } catch (e) {
      Logger().e('Error fetching following: $e');
      following.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
