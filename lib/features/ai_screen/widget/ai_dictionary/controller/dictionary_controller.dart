import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DictionaryController extends GetxController {
  final searchController = TextEditingController();

  var isLoading = false.obs;
  var result = "".obs;

  /// Search word function
  void searchWord() async {
    String query = searchController.text.trim();

    if (query.isEmpty) {
      Get.snackbar(
        "Warning",
        "Please enter a word!",
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    isLoading.value = true;
    result.value = "";

    await Future.delayed(Duration(seconds: 1));

    result.value = """
🔍 **Word:** $query

📘 **Meaning:** This is a sample meaning generated for the word "$query".

📝 **Example Sentence:**  
"The word '$query' is used here as an example."

""";

    isLoading.value = false;
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
