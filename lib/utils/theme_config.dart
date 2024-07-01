import 'package:blinqpost/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeConfig {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: AppColors.primaryLight,
    brightness: Brightness.light,
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 54.sp,
        fontWeight: FontWeight.w900,
        fontStyle: FontStyle.italic,
        //color: AppColors.primaryLight,
      ),
      titleLarge: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      bodyLarge: const TextStyle(fontSize: 16.0),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    primaryColor: AppColors.primaryDark,
    brightness: Brightness.dark,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
      bodyLarge: TextStyle(fontSize: 16.0, color: Colors.white),
    ),
  );
}
