
import 'package:get/get.dart';
import 'package:online_study/features/peer_screens/widgets/find_friends.dart';
import 'package:online_study/features/peer_screens/widgets/follower_screen.dart';
import 'package:online_study/features/peer_screens/widgets/following_screen.dart';

class PeerScreenController extends GetxController {
  RxInt selectedIndex = 0.obs;

  final screens = [
    FollowerScreen(),
    FollowingScreen(),
    FindFriends(),
  ];
}