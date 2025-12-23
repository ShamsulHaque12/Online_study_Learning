import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../widget/group_chat.dart';
import '../widget/personal_chat.dart';

class ChatController extends GetxController {
  final searchController = TextEditingController();
  RxInt selectedIndex = 0.obs;

  final screens = [
    PersonalChat(),
    GroupChat(),
  ];
}