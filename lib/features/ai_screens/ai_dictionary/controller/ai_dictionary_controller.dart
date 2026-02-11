import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:online_study/features/ai_screens/ai_dictionary/model/dictionary_model.dart';
import 'package:online_study/features/ai_screens/ai_dictionary/model/save_book_mark_data.dart';
import 'package:online_study/services/api_endpoints.dart';
import 'package:online_study/services/network_caller.dart';

class AiDictionaryController extends GetxController {
  final searchController = TextEditingController();
  final FlutterTts flutterTts = FlutterTts();

  Rx<Data?> dictionaryData = Rx<Data?>(null);
  RxList<BookmarkData> bookmarkList = <BookmarkData>[].obs;

  final isBookmarked = false.obs;
  final isSavingBookmark = false.obs;

  final isLoading = false.obs;
  final errorMessage = "".obs;

  @override
  void onInit() {
    super.onInit();
    _initTts();
    getDataFromDatabase();
  }

  /// Search word in dictionary
  Future<void> searchWord() async {
    if (searchController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Enter your Word",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = "";
      dictionaryData.value = null;

      final response = await NetworkCaller().postRequest(
        url: ApiEndpoints.dictionary,
        body: {"word": searchController.text},
      );

      if (response.isSuccess && response.responseData != null) {
        final model = DictionaryModel.fromJson(response.responseData!);

        if (model.data != null) {
          dictionaryData.value = model.data;

          // ✅ After getting data, check bookmark status
          await getDataFromDatabase();
        } else {
          errorMessage.value = "No data found";
          log("error");
        }
      } else {
        errorMessage.value = response.errorMessage;
        log('error');
      }
    } catch (e) {
      errorMessage.value = e.toString();
      log("error$e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Get bookmark data from database
  Future<void> getDataFromDatabase() async {
    try {
      isLoading.value = true;
      errorMessage.value = "";

      final response = await NetworkCaller().getRequest(
        url: ApiEndpoints.getSavePost,
      );

      if (response.isSuccess && response.responseData != null) {
        final model = SaveBookMarkData.fromJson(response.responseData!);

        // Populate bookmark list
        bookmarkList.value = model.data ?? [];

        // Check if current word is bookmarked
        if (dictionaryData.value != null) {
          final currentWord = dictionaryData.value!.word;
          isBookmarked.value = bookmarkList.any(
            (item) => item.word == currentWord,
          );
        }
      } else {
        errorMessage.value = response.errorMessage;
      }
    } catch (e) {
      log(e.toString());
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  /// Save word to database
  Future<void> saveDataToDatabase() async {
    if (isBookmarked.value || isSavingBookmark.value) return;

    if (dictionaryData.value == null) {
      Get.snackbar(
        "Error",
        "No data to save",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isSavingBookmark.value = true;
      final data = dictionaryData.value!;

      final response = await NetworkCaller().postRequest(
        url: ApiEndpoints.savePost,
        body: {
          "word": data.word,
          "syllables": data.syllables,
          "meanings": data.meanings,
          "english_sentence": data.englishSentence,
          "sentence_in_language": data.sentenceInLanguage,
          "language": data.language,
        },
      );

      if (response.isSuccess) {
        isBookmarked.value = true;
        log("Word saved successfully");

        // Add to bookmark list locally
        bookmarkList.add(
          BookmarkData(
            word: data.word,
            syllables: data.syllables,
            meanings: data.meanings,
            englishSentence: data.englishSentence,
            sentenceInLanguage: data.sentenceInLanguage,
            language: data.language,
          ),
        );

        Get.snackbar(
          "Success",
          "Word saved successfully",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        log(response.errorMessage);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isSavingBookmark.value = false;
    }
  }

  /// Initialize Text-to-Speech
  Future<void> _initTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.30);
    await flutterTts.setPitch(1.0);
  }

  Future<void> speakWord(String word) async {
    if (word.isEmpty) return;
    await flutterTts.stop();
    await flutterTts.speak(word);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
