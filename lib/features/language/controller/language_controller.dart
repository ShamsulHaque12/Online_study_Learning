
import 'package:get/get.dart';
import 'package:online_study/features/language/utils/en_US.dart';
import 'package:online_study/features/language/utils/tl_PH.dart';
import 'package:online_study/services/shared_preferences_helper.dart';

class LanguageController extends GetxController {
  RxString selected = 'English'.obs;
  RxMap<String, String> selectedLanguage = <String, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _getLanguage();
  }

  void _getLanguage() async {
    final lang = await SharedPreferencesHelper.getLanguage();
    if (lang == "tl-PH") {
      selected.value = "Tagalog";
      selectedLanguage
        ..clear()
        ..addAll(tagalog);
    } else {
      selected.value = "English";
      selectedLanguage
        ..clear()
        ..addAll(english);
    }
  }

  Future<void> saveLanguage(String language) async {
    await SharedPreferencesHelper.saveLanguage(language);
    _getLanguage();
  }
}
