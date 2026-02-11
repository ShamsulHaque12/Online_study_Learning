
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:online_study/features/ai_screens/ai_camera/screens/ai_camera_screen.dart';
import 'package:online_study/features/ai_screens/ai_dialouge/screens/ai_dialouge_screen.dart';
import 'package:online_study/features/ai_screens/ai_dictionary/screens/ai_dictionary_screen.dart';
import 'package:online_study/features/ai_screens/ai_flash_card/screens/ai_flash_card.dart';
import 'package:online_study/features/ai_screens/ai_role_play_simulation/screens/ai_role_play_screen.dart';
import 'package:online_study/features/ai_screens/ai_role_play_talk/screens/ai_role_play_talk.dart';
import 'package:online_study/features/ai_screens/ai_story/screens/ai_stroy_screen.dart';
import 'package:online_study/features/ai_screens/ai_writting/screens/ai_writting_screen.dart';
import 'package:online_study/features/ai_screens/ai_writting/screens/response_writting.dart';
import 'package:online_study/features/ai_screens/lisining_dialouge/screens/lisining_dialouge.dart';
import 'package:online_study/features/bottom-nav/bindings/bottom_nav_bindings.dart';
import 'package:online_study/features/bottom-nav/ui/screen/bottom_nav_screen.dart';
import 'package:online_study/features/challenges/bindings/challenges_bindings.dart';
import 'package:online_study/features/challenges/ui/screens/challenges_game.dart';
import 'package:online_study/features/home/ui/screens/lesson_title_screen.dart';
import 'package:online_study/features/lesson_content/screens/lesson_content_screen.dart';
import 'package:online_study/features/notification/screens/notification_screen.dart';
import 'package:online_study/features/onboarding/onboarding_screen/screen/onboarding_name_screen.dart';
import 'package:online_study/features/search_friend/screens/search_friend_view.dart';
import 'package:online_study/features/setting_screen/screens/setting_screen.dart';
import 'package:online_study/features/splash/bindings/splash_binding.dart';
import 'package:online_study/features/splash/ui/screen/splash_screen.dart';
import 'package:online_study/features/welcome/ui/screens/welcome_screen.dart';
import 'package:online_study/route/app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splashScreen,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(name: AppRoutes.welcomeScreen, page: () => WelcomeScreen()),
    GetPage(
      name: AppRoutes.onboardingNameScreen,
      page: () => OnboardingNameScreen(),
    ),

    GetPage(
      name: AppRoutes.bottomNavScreen,
      page: () => BottomNavScreen(),
      binding: BottomNavBindings(),
    ),

    GetPage(
      name: AppRoutes.challengesScreen,
      page: () => ChallengesScreen(),
      binding: ChallengesBindings(),
    ),
    GetPage(
      name: AppRoutes.settingScreen,
      page: () => SettingScreen(),
    ),
    GetPage(
      name: AppRoutes.lisiningDialougeScreen,
      page: () => LisiningDialouge(),
    ),
    GetPage(
      name: AppRoutes.writingPracticeScreen,
      page: () => AiWrittingScreen(),
    ),
    GetPage(name: AppRoutes.aiDictionary, page: ()=>AiDictionaryScreen()),
    GetPage(name: AppRoutes.aiCamera, page: ()=>AiCameraScreen()),
    GetPage(name: AppRoutes.aiStoryScreen, page: ()=> AiStroyScreen()),
    GetPage(name: AppRoutes.aiRolePlayScreen, page: ()=>AiRolePlayScreen()),
    GetPage(name: AppRoutes.aiDialougeScreen, page: ()=>AiDialougeScreen()),
    GetPage(name: AppRoutes.aiFlashCard, page: ()=>AiFlashCard()),
    GetPage(name: AppRoutes.aiRolePlayTalk, page: ()=>AiRolePlayTalk()),
    GetPage(name: AppRoutes.notificationScreen, page: ()=>NotificationScreen()),
    GetPage(name: AppRoutes.responseWrittingScreen, page: ()=>ResponseWritting()),
    GetPage(name: AppRoutes.lessonTitleScreen, page: ()=>LessonTitleScreen()),
    GetPage(name: AppRoutes.lessonContentScreen, page: ()=> LessonContentScreen()),
    GetPage(name: AppRoutes.searchFriendView, page: ()=> SearchFriendView()),

  ];
}
