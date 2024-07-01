import 'package:blinqpost/view-model/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class AppColors {
  late Color primaryColor;
  late Color borderColor;
  late Color profileIconColor;
  late Color primaryTextColor;
  late Color selectedLabelColor;
  late Color unselectedLabelColor;
  static const Color primaryDark = Color(0xFF0D1F23);
  static const Color primaryLight = Color(0xFFAFB3B7);
}

class LightColors implements AppColors {
  static const _primaryColor = Color(0xFF0D1F23);

  static const _white = Colors.white;

  @override
  Color primaryColor = _primaryColor;

  @override
  Color borderColor = _primaryColor;

  @override
  Color primaryTextColor = Colors.black;

  @override
  Color selectedLabelColor = _white;

  @override
  Color unselectedLabelColor = _primaryColor;
  
  @override
  Color profileIconColor = _white;
}

class DarkColors implements AppColors {
  static const _primaryColor = Color(0xFF0D1F23);

  static const _lightGrey = Color(0xFFAFB3B7);

  static const _white = Colors.white;

  @override
  Color primaryColor = _primaryColor;

  @override
  Color borderColor = _lightGrey;

  @override
  Color primaryTextColor = Colors.white;

  @override
  Color selectedLabelColor = _white;

  @override
  Color unselectedLabelColor = _white;
  
  @override
  Color profileIconColor = _primaryColor;
}

final appColorProvider = Provider<AppColors>((ref) {
  final isDarkMode = ref.watch(isDarkModeProvider);
  return isDarkMode ? DarkColors() : LightColors();
});
