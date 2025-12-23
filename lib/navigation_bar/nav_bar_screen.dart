import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../core/app_colours.dart';
import '../core/app_icons.dart';
import '../features/ai_screen/screens/ai_screen_view.dart';
import '../features/community_screen/screens/change_screen_view.dart';
import '../features/home_screen/screens/home_screen_view.dart';
import '../features/profile_screen/screens/profile_screen.dart';
import '../features/progress_screen/screens/progress_screen_view.dart';

/// Navigation Bar Item Model
class NavBarItem {
  final String icon;
  final String label;

  NavBarItem({
    required this.icon,
    required this.label,
  });
}

/// Custom Bottom Navigation Bar - Responsive + Dark/Light aware
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<NavBarItem> items;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? backgroundColor;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.activeColor,
    this.inactiveColor,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final bottomPadding = media.padding.bottom;
    final navHeight = (media.size.height * 0.09) + bottomPadding;

    return Container(
      height: navHeight,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            items.length,
                (index) => _buildNavItem(
              item: items[index],
              isActive: currentIndex == index,
              onTap: () => onTap(index),
              maxHeight: navHeight - bottomPadding - 8.h,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required NavBarItem item,
    required bool isActive,
    required VoidCallback onTap,
    required double maxHeight,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
          constraints: BoxConstraints(maxHeight: maxHeight),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                item.icon,
                width: 24.w,
                height: 24.h,
                color: isActive ? Colors.orange : Colors.grey[600],
              ),
              SizedBox(height: 2.h),
              if (isActive)
                Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.orange,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// NavBar Screen with full MediaQuery responsiveness + Dark/Light bg
class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int _currentIndex = 2;

  // Screens
  final List<Widget> _screens = [
     AiScreenView(),
     ProgressScreenView(),
     HomeScreenView(),
     ChangeScreenView(),
     ProfileScreen(),
  ];

  // Nav items
  final List<NavBarItem> _navItems = [
    NavBarItem(icon: AppIcons.ai, label: 'AI'),
    NavBarItem(icon: AppIcons.progress, label: 'Progress'),
    NavBarItem(icon: AppIcons.home, label: 'Home'),
    NavBarItem(icon: AppIcons.change, label: 'Community'),
    NavBarItem(icon: AppIcons.profile, label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final media = MediaQuery.of(context);
    final availableHeight =
        media.size.height - media.padding.top - media.padding.bottom;

    // Background switch
    final bgColor = isDark ? AppColors.bgDark : AppColors.bgLight;

    return Scaffold(
      backgroundColor: bgColor,
      body: SizedBox(
        height: availableHeight,
        width: double.infinity,
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: _navItems,
        activeColor: Colors.orange,
        inactiveColor: Colors.grey[600],
        backgroundColor: bgColor,
      ),
    );
  }
}
