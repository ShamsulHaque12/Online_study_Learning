
import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'package:online_study/features/language/utils/en_US.dart';
import 'package:online_study/features/language/utils/tl_PH.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    "en_US": english,
    "da_DK": tagalog,
  };
}
