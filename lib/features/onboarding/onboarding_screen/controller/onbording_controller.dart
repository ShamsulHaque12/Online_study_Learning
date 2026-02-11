
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:online_study/features/onboarding/onboarding_screen/screen/welcome_screen_to_home.dart';
import 'package:online_study/global/data/days_name.dart';
import 'package:online_study/global/data/like_to_improve_data.dart';
import 'package:online_study/global/data/skills_data.dart';
import 'package:online_study/global/data/study_time.dart';
import 'package:online_study/global/data/works_data.dart';
import 'package:online_study/global/widgets/error_toast_message.dart';
import 'package:online_study/global/widgets/success_snakbar.dart';
import 'package:online_study/services/api_endpoints.dart';
import 'package:online_study/services/network_caller.dart';
import 'package:online_study/services/shared_preferences_helper.dart';

class OnbordingController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isLoading = false.obs;

  ///Servey Language learn..........
  RxString selectedLearnLanguage = 'English'.obs;
  void selectLearnLanguage(String language) {
    selectedLearnLanguage.value = language;
  }

  ///Native Language..........
  RxString selectedLanguage = 'English'.obs;
  void selectLanguage(String language) {
    selectedLanguage.value = language;
  }

  /// 0 -> Beginner, 1 -> Intermediate, 2 -> Advanced
  RxInt selectedSkill = (-1).obs;
  void selectSkill(int index) {
    selectedSkill.value = index;
  }

  //* Servey skill improve...........
  RxList<int> selectedImproveSkills = <int>[].obs;
  RxList<String> selectedImproveSkillsNames = <String>[].obs;
  void toggleImproveSkill(int index) {
    if (selectedImproveSkills.contains(index)) {
      selectedImproveSkills.remove(index);
      selectedImproveSkillsNames.remove(
        likeToImprove[index]["name"].toString(),
      );
    } else {
      selectedImproveSkills.add(index);
      selectedImproveSkillsNames.add(likeToImprove[index]["name"].toString());
    }
  }

  /// times.............
  RxInt selectedTime = (-1).obs;
  void selectTimes(int index) {
    selectedTime.value = index;
  }

  /// works....................
  RxInt selectedWork = (-1).obs;
  void selectWork(int index) {
    selectedWork.value = index;
  }

  /// Reminder ................
  RxList<int> selectedDays = <int>[].obs;
  RxList<String> selectedDaysNames = <String>[].obs;
  RxInt selectedHour = 5.obs;
  RxInt selectedMinute = 48.obs;
  RxString selectedPeriod = "PM".obs;
  void toggleDay(int index) {
    if (selectedDays.contains(index)) {
      selectedDays.remove(index);
      selectedDaysNames.remove(days[index]);
    } else {
      selectedDays.add(index);
      selectedDaysNames.add(days[index]);
    }
  }

  void setHour(int v) => selectedHour.value = v;
  void setMinute(int v) => selectedMinute.value = v;
  void setPeriod(String period) => selectedPeriod.value = period;

  /// label....................
  RxInt selectedLabel = (-1).obs;
  void selectlabel(int index) {
    selectedLabel.value = index;
  }

  //*Create Account

  Future<void> createAccount(BuildContext context) async {
    final networkCaller = NetworkCaller();
    try {
      isLoading.value = true;
      final response = await networkCaller.postRequest(
        url: ApiEndpoints.createAccount,
        body: {
          "fullName": nameController.text,
          "email": emailController.text,
          "preferedLanguage": selectedLearnLanguage.value == "English"
              ? "en-US"
              : "tl-PH",
          "nativeLanguage": selectedLanguage.value == "English"
              ? "en-US"
              : "tl-PH",
          "reasonToLearn": works[selectedWork.value]['title'],
          "howMuchTimeCanYouGive": int.parse(
            times[selectedTime.value]['title']
                .toString()
                .substring(0, 2)
                .trim(),
          ),
          "aspectOfLearning": selectedImproveSkillsNames.toList(),
          "whichDayWantReminder": selectedDaysNames.toList(),
          "levelOfFluncy": skills[selectedSkill.value]['title'],
          "startFrom": selectedLabel.value == 0
              ? "Learning English for the first time"
              : "Already know some English?",
          "password": passwordController.text,
        },
      );
      if (response.isSuccess) {
        SharedPreferencesHelper.saveAccessToken(
          response.responseData?['data']['accessToken'],
        );
        Logger().i(
          "Account created successfully\nResponse: ${response.responseData}",
        );
        SuccessSnackBar.show(
          context,
          response.responseData?['message'] ?? "Account Created Successfully",
        );
        Get.offAll(() => WelcomeScreenToHome());
      } else {
        ErrorToastMessage.show(response.errorMessage);
        log("Account creation failed: ${response.errorMessage}");
      }
    } catch (e) {
      ErrorToastMessage.show("Error creating account. Please try again.");
      Logger().e("Error creating account: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
