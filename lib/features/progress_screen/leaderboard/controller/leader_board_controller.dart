import 'package:get/get.dart';

import '../model/friends_model.dart';

class LeaderBoardController extends GetxController {
  /// Tab Bar............
  RxInt selectedTab = 0.obs;
  void changeTab(int index) {
    selectedTab.value = index;
  }
  /// model Data................
  RxList<FriendsModel> friends = <FriendsModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchFriends();
  }

  void fetchFriends() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));
    List<FriendsModel> friendList = [
      FriendsModel(
        image: "https://i.imgur.com/BoN9kdC.png",
        name: "Camelia",
        point: "992",
      ),
      FriendsModel(
        image: "https://i.imgur.com/2yaf2wb.png",
        name: "Maxwell",
        point: "1200",
      ),
      FriendsModel(
        image: "https://i.imgur.com/tEcsk5u.png",
        name: "Wilson",
        point: "850",
      ),
    ];

    friends.assignAll(friendList);
  }
}