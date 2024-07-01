import 'package:blinqpost/services/third_party_services/shared_preferences_service.dart';
import 'package:blinqpost/utils/storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    return SharedPreferenceService().darkMode
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  void toggleTheme(bool value) {}

  void switchToDarkMode() {
    state = ThemeMode.dark;
    SharedPreferenceService().saveBool(StorageKeys.darkMode, true);
  }

  void switchToLightMode() {
    state = ThemeMode.light;
    SharedPreferenceService().saveBool(StorageKeys.darkMode, false);
  }

  bool get isDarkMode => state == ThemeMode.dark;
}

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);

final isDarkModeProvider = Provider<bool>((ref) {
  final themeMode = ref.watch(themeModeProvider);
  return themeMode == ThemeMode.dark;
});
