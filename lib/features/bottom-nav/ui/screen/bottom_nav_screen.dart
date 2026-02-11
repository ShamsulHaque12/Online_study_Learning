
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_icons.dart';
import 'package:online_study/features/Ai/ui/screens/ai_screen.dart';
import 'package:online_study/features/bottom-nav/controller/bottom_nav_controller.dart';
import 'package:online_study/features/home/ui/screens/home_screen.dart';
import 'package:online_study/features/peer_screens/screens/peer_screen.dart';
import 'package:online_study/features/profile_screen/screens/profile_screen.dart';
import 'package:online_study/features/progress_screen/screens/progress_screen.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class BottomNavScreen extends StatelessWidget {
  const BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavController controller = Get.put(BottomNavController());
    final themeController = Get.find<ThemeController>();

    final List<Widget> screens = [
      AiScreen(),
      ProgressScreen(),
      HomeScreen(),
      PeerScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      body: Obx(() => screens[controller.currentIndex.value]),
      bottomNavigationBar: Obx(() {
        final isDarkMode = themeController.isDark.value;

        return BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: isDarkMode
              ? AppDarkColors.backgroundColor
              : AppLightColors.backgroundColor,
          selectedItemColor: const Color(0xFFFF6B35),
          unselectedItemColor: isDarkMode
              ? Colors.white
              : const Color(0xff212529),
          selectedFontSize: 12,
          unselectedFontSize: 0,
          showUnselectedLabels: false,
          elevation: 8,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.aiIcon,
                height: 24,
                colorFilter: ColorFilter.mode(
                  controller.currentIndex.value == 0
                      ? const Color(0xFFFF6B35)
                      : isDarkMode
                      ? Colors.white
                      : const Color(0xff212529),
                  BlendMode.srcIn,
                ),
              ),
              label: 'AI',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.progressIcon,
                height: 24,
                colorFilter: ColorFilter.mode(
                  controller.currentIndex.value == 1
                      ? const Color(0xFFFF6B35)
                      : isDarkMode
                      ? Colors.white
                      : const Color(0xff212529),
                  BlendMode.srcIn,
                ),
              ),
              label: 'Progress',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.homeIcon,
                height: 24,
                colorFilter: ColorFilter.mode(
                  controller.currentIndex.value == 2
                      ? const Color(0xFFFF6B35)
                      : isDarkMode
                      ? Colors.white
                      : const Color(0xff212529),
                  BlendMode.srcIn,
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.peerIcon,
                height: 24,
                colorFilter: ColorFilter.mode(
                  controller.currentIndex.value == 3
                      ? const Color(0xFFFF6B35)
                      : isDarkMode
                      ? Colors.white
                      : const Color(0xff212529),
                  BlendMode.srcIn,
                ),
              ),
              label: 'Peer',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.profileIcon,
                height: 24,
                colorFilter: ColorFilter.mode(
                  controller.currentIndex.value == 4
                      ? const Color(0xFFFF6B35)
                      : isDarkMode
                      ? Colors.white
                      : const Color(0xff212529),
                  BlendMode.srcIn,
                ),
              ),
              label: 'Profile',
            ),
          ],
        );
      }),
    );
  }
}
