import 'package:get/get.dart';
import '../widget/chating_screen.dart';
import '../widget/find_friends_screen.dart';
import '../widget/follower_screen.dart';
import '../widget/following_screen.dart';

class PeerController extends GetxController {
  RxInt selectedIndex = 0.obs;

  final screens = [
    FollowerScreen(),
    FollowingScreen(),
    FindFriendsScreen(),
    ChatingScreen(),
  ];
}
