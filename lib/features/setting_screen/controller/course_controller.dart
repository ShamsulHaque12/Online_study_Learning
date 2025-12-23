import 'package:get/get.dart';

class CourseController extends GetxController {
  RxString selectedLanguage = 'English (British)'.obs;

  void selectLanguage(String language) {
    selectedLanguage.value = language;
  }
}