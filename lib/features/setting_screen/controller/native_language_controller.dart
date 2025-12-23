import 'package:get/get.dart';

class NativeLanguageController extends GetxController {
  RxString selectedLanguage = 'English (British)'.obs;

  void selectLanguage(String language) {
    selectedLanguage.value = language;
  }

}