import 'package:get/get.dart';
import 'package:online_study/features/language/controller/language_controller.dart';

class NativeLanguageController extends GetxController {
  RxString selectedLanguage = 'English'.obs;

  @override
  onInit() {
    super.onInit();
    final langController = Get.find<LanguageController>();
    selectedLanguage.value = langController.selected.value;
  }

  Future<void> selectLanguage(String language) async {
    selectedLanguage.value = language;
    final langController = Get.find<LanguageController>();
    if (selectedLanguage.value == "English") {
      await langController.saveLanguage("en-US");
    } else {
      await langController.saveLanguage("tl-PH");
    }
  }
}
