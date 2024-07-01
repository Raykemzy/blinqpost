import 'dart:convert';

import 'package:blinqpost/utils/storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  factory SharedPreferenceService() => _instance;
  static final SharedPreferenceService _instance =
      SharedPreferenceService._internal();
  SharedPreferenceService._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    print(_prefs);
  }

  Future<void> saveBool(String key, bool value) async {
    if (_prefs == null) return;
    await _prefs?.setBool(key, value);
  }

  bool getBool(String key) {
    return _prefs?.getBool(key) ?? false;
  }

  Future<void> saveDynamic(String key, dynamic value) async {
    String jsonString = jsonEncode(value);
    await _prefs?.setString(key, jsonString);
  }

  dynamic getDynamic(String key) {
    String? jsonString = _prefs?.getString(key);
    return jsonString != null ? jsonDecode(jsonString) : null;
  }

  Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  bool get darkMode {
    final isDarkMode = _prefs?.getBool(StorageKeys.darkMode) ?? false;
    return isDarkMode;
  }
}
