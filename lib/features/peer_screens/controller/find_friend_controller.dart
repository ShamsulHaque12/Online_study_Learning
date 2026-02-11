import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:online_study/services/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FindFriendController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  RxBool isLoading = false.obs;
  RxList<Map<String, dynamic>> friends = <Map<String, dynamic>>[].obs;
  RxString searchText = ''.obs;

  late Worker debounceWorker;

  @override
  void onInit() {
    super.onInit();
    debounceWorker = debounce(
      searchText,
      (value) => searchFriends(value),
      time: const Duration(milliseconds: 300),
    );
  }

  Future<void> searchFriends(String query) async {
    if (query.trim().isEmpty) {
      friends.clear();
      return;
    }

    try {
      isLoading.value = true;

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      final response = await http.get(
        Uri.parse("${ApiEndpoints.searchBox}$query"),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        friends.value =
            List<Map<String, dynamic>>.from(decoded["data"] ?? []);
      } else {
        friends.clear();
      }
    } catch (e) {
      friends.clear();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    debounceWorker.dispose();
    searchController.dispose();
    super.onClose();
  }
}
