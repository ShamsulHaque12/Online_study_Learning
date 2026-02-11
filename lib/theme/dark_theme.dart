import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';

class DarkTheme {
  static final ThemeData darkThemeData = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppDarkColors.backgroundColor,
    textTheme: GoogleFonts.interTextTheme(),



    //-------------------------- App Bar Theme --------------------------//
    appBarTheme: AppBarTheme(
      backgroundColor: AppDarkColors.backgroundColor,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),

    //-------------------------------Input Decoration Theme---------------------------------//
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppDarkColors.backgroundColor,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppDarkColors.textFieldBorderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppDarkColors.textFieldBorderColor),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: Color(0xffA5D8FF)),
      ),
      hintStyle: TextStyle(color: AppDarkColors.textFieldBorderColor),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 16.0,
      ),
    ),
  );
}
