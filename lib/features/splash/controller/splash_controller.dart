
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:logger/logger.dart';
import 'package:online_study/route/app_routes.dart';
import 'package:online_study/services/shared_preferences_helper.dart';

class SplashController extends GetxController {
  late String accessToken;
  final Logger logger = Logger();

  @override
  void onInit() async {
    super.onInit();
    accessToken =await SharedPreferencesHelper.getAccessToken()??'' ;
    moveToNextScreen();
  }

  Future<void> moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    if (accessToken.trim().isNotEmpty) {
      logger.d('Access Token: $accessToken');
      checkAccessToken();
    } else {
      Get.offAllNamed(AppRoutes.welcomeScreen);
    }
  }

  void checkAccessToken() {
    final bool isExpired = JwtDecoder.isExpired(accessToken.toString());

    if (isExpired) {
      Get.offAllNamed(AppRoutes.welcomeScreen);
    } else {
      Get.offAllNamed(AppRoutes.bottomNavScreen);
    }
  }
}
