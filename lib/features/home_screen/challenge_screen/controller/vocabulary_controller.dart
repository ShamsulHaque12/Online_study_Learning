import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/app_colours.dart';
import '../model/word_item.dart';

class VocabularyController extends GetxController {
  RxBool isDark = false.obs;

  @override
  void onInit() {
    super.onInit();
    isDark.value = Get.isDarkMode;
  }

  // Default background based on theme
  Color defaultBg() => isDark.value ? const Color(0xFF2A2A2A) : Colors.white;

  // English Words
  RxList<WordItem> englishWords = <WordItem>[
    WordItem(text: "Good Morning"),
    WordItem(text: "Good Afternoon"),
    WordItem(text: "Good Evening"),
    WordItem(text: "Good Bye"),
    WordItem(text: "I’m fine"),
  ].obs;

  // Filipino Words
  RxList<WordItem> filipinoWords = <WordItem>[
    WordItem(text: "Magandang umaga"),
    WordItem(text: "Magandang hapon"),
    WordItem(text: "Magandang gabi"),
    WordItem(text: "Paalam"),
    WordItem(text: "Mabuti naman"),
  ].obs;

  // Selected Items
  Rx<WordItem?> selectedEnglish = Rx<WordItem?>(null);
  Rx<WordItem?> selectedFilipino = Rx<WordItem?>(null);

  // ---------------------------
  // SELECT ENGLISH
  // ---------------------------
  void selectEnglish(WordItem item) {
    if (item.isLocked) return;

    for (var e in englishWords) {
      if (!e.isLocked) e.bgColor = defaultBg();
    }

    item.bgColor = AppColors.checkColor;
    selectedEnglish.value = item;
    update();
  }

  // ---------------------------
  // SELECT FILIPINO
  // ---------------------------
  void selectFilipino(WordItem item) {
    if (item.isLocked) return;

    for (var f in filipinoWords) {
      if (!f.isLocked) f.bgColor = defaultBg();
    }

    item.bgColor = AppColors.checkColor;
    selectedFilipino.value = item;
    update();
  }

  // ---------------------------
  // CHECK MATCH
  // ---------------------------
  void checkMatch() {
    if (selectedEnglish.value == null || selectedFilipino.value == null) return;

    WordItem eng = selectedEnglish.value!;
    WordItem fil = selectedFilipino.value!;

    bool isCorrect = _validate(eng.text, fil.text);

    if (isCorrect) {
      eng.bgColor = AppColors.correctColor;
      fil.bgColor = AppColors.correctColor;
      eng.isLocked = true;
      fil.isLocked = true;
    } else {
      eng.bgColor = AppColors.wrongColor;
      fil.bgColor = AppColors.wrongColor;
    }

    selectedEnglish.value = null;
    selectedFilipino.value = null;

    update();
    _checkCompletion();
  }

  // MATCH LOGIC
  bool _validate(String eng, String fil) {
    return (eng == "Good Morning" && fil == "Magandang umaga") ||
        (eng == "Good Afternoon" && fil == "Magandang hapon") ||
        (eng == "Good Evening" && fil == "Magandang gabi") ||
        (eng == "Good Bye" && fil == "Paalam") ||
        (eng == "I’m fine" && fil == "Mabuti naman");
  }

  // CHECK COMPLETE
  void _checkCompletion() {
    bool allLocked = englishWords.every((e) => e.isLocked);

    if (allLocked) {
      Get.defaultDialog(
        title: "Great Job!",
        middleText: "You've matched all words correctly!",
        confirm: ElevatedButton(
          onPressed: () => Get.back(),
          child: Text("OK"),
        ),
      );
    }
  }
}
