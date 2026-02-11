
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_study/route/app_pages.dart';
import 'package:online_study/route/app_routes.dart';
import 'package:online_study/theme/dark_theme.dart';
import 'package:online_study/theme/light_theme.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return Obx(() {
          return GetMaterialApp(
            title: 'Online Study',
            theme: LightTheme.lightThemeData,
            darkTheme: DarkTheme.darkThemeData,
            themeMode: themeController.themeMode,
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.splashScreen,
            getPages: AppPages.pages,
          );
        });
      },
    );
  }
}
