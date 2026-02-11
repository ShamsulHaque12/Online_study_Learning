import 'dart:developer';
import 'package:get/get.dart';
import 'package:online_study/features/search_friend/model/find_friend.dart';
import 'package:online_study/services/api_endpoints.dart';
import 'package:online_study/services/network_caller.dart';

class SearchFriendController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<FindFriend?> friendProfile = Rx<FindFriend?>(null);

  late String userId;

  @override
  void onInit() {
    super.onInit();
    userId = Get.arguments;
    fetchFriendProfile();
  }

  Future<void> fetchFriendProfile() async {
    try {
      isLoading.value = true;

      final response = await NetworkCaller().getRequest(
        url: ApiEndpoints.findFriends + userId,
      );

      if (response.isSuccess) {
        friendProfile.value = FindFriend.fromJson(response.responseData!);
        log("Friend Profile Loaded");
      } else {
        log("Failed to load friend profile");
      }
    } catch (e) {
      log("Profile Error: $e");
    } finally {
      isLoading.value = false; 
    }
  }

  /// Follow User
  Future<bool> followUser() async {
    try {
      final response = await NetworkCaller().postRequest(
        url: ApiEndpoints.followUser,
        body: {"targetUserId": userId},
      );

      if (response.isSuccess) {
        log("Successfully followed user");
        return true;
      } else {
        log("Failed to follow user");
        return false;
      }
    } catch (e) {
      log("Follow Error: $e");
      return false;
    }
  }
}
