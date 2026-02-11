import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';

class LightTheme {
  static final ThemeData lightThemeData = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppLightColors.backgroundColor,
    textTheme: GoogleFonts.interTextTheme(),

    //-------------------------- App Bar Theme --------------------------//
    appBarTheme: AppBarTheme(
      backgroundColor: AppLightColors.backgroundColor,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),

    //-------------------------- Input Decoration Theme --------------------------//
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppLightColors.textFieldBorderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppLightColors.textFieldBorderColor),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: Color(0xffA5D8FF)),
      ),
      hintStyle: TextStyle(color: AppLightColors.textFieldBorderColor),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 16.0,
      ),
    ),
  );
}
