import 'dart:developer';
import 'package:get/get.dart';
import 'package:online_study/features/home/model/get_chapter1_data.dart';
import 'package:online_study/features/home/model/get_user_model.dart';
import 'package:online_study/features/home/model/percentage_data.dart';
import 'package:online_study/features/lesson_content/model/content_model.dart';
import 'package:online_study/services/api_endpoints.dart';
import 'package:online_study/services/network_caller.dart';

class LessonController extends GetxController {
  final isLoading = false.obs;

  /// Auth User (Reactive)
  final Rxn<UserData> user = Rxn<UserData>();

  /// Chapter list
  final RxList<ChapterData> chapters = <ChapterData>[].obs;

  /// Chapter percentages
  final RxMap<int, int> chapterPercentages = <int, int>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUser();
    fetchChapterData();
  }

  /// Fetch Chapter Data
  Future<void> fetchChapterData() async {
    isLoading.value = true;
    try {
      final response = await NetworkCaller().getRequest(
        url: ApiEndpoints.lessonTitle,
      );

      if (response.isSuccess) {
        final model = GetChapter1Model.fromJson(
          response.responseData as Map<String, dynamic>,
        );
        chapters.assignAll(model.data);

        // Fetch percentage for each chapter after loading chapters
        fetchAllChapterPercentages();
      } else {
        log("Error: ${response.errorMessage}");
      }
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetch Auth User
  Future<void> fetchUser({bool force = false}) async {
    if (!force && user.value != null) return;

    try {
      final response = await NetworkCaller().getRequest(
        url: ApiEndpoints.getUser,
      );

      if (response.isSuccess) {
        final model = GetUserModel.fromJson(
          response.responseData as Map<String, dynamic>,
        );
        user.value = model.data;
      } else {
        Get.snackbar("Error", response.errorMessage);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  /// Fetch Lesson By ID
  Future<ContentModel?> fetchLessonById(String id) async {
    isLoading.value = true;
    try {
      final response = await NetworkCaller().getRequest(
        url: '${ApiEndpoints.lessonPart1}$id',
      );
      if (response.isSuccess && response.responseData != null) {
        return ContentModel.fromJson(response.responseData!);
      } else {
        Get.snackbar("Error", response.errorMessage);
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetch Percentage for All Chapters
  Future<void> fetchAllChapterPercentages() async {
    try {
      for (var i = 0; i < chapters.length; i++) {
        final response = await NetworkCaller().getRequest(
          url: '${ApiEndpoints.chapterPercent}$i',
        );

        if (response.isSuccess) {
          log("Fetched percentage for chapter $i");
          final percentageResponse = PercentageData.fromJson(
            response.responseData!,
          );

          log(
            "RESPONSE FOR CHAPTER $i: ${percentageResponse.data?.percentage}",
          );
          chapterPercentages[percentageResponse.data?.chapter ?? 0] =
              percentageResponse.data?.percentage ?? 0;
        } else {
          log("Failed to fetch percentage for chapter $i");
          chapterPercentages[i] = 0; 
        }
      }
      // Correct URL using query parameter
    } catch (e) {
      log(e.toString());
    }
  }
}
