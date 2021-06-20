import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  //final SharedPreferences preferences;

  // SharedPrefHelper({required this.preferences});

  static const _lastChecked = 'last_checked';
  static const _checkInterval = 'check_interval';
  static const _data = 'data';
  static const _theme = 'theme';

  Future<SharedPreferences> preferences = SharedPreferences.getInstance();

  // Interval 600000 means handle cache for 600000 milliseconds or 10 minutes
  Future<bool> storeCache(String key, String json, {int? lastChecked, int interval = 600000}) async {
    if (lastChecked == null) {
      lastChecked = DateTime.now().millisecondsSinceEpoch;
    }
    return (await preferences).setString(key, jsonEncode({_lastChecked: lastChecked, _checkInterval: interval, _data: json}));
  }

  Future<String?> getCache(String key) async {
    var result = (await preferences).getString(key);
    if (result == null) {
      return null;
    }
    Map map = jsonDecode(result);
    // if outdated, clear and return null
    var lastChecked = map[_lastChecked];
    var interval = map[_checkInterval];
    if ((DateTime.now().millisecondsSinceEpoch - lastChecked) > interval) {
      (await preferences).remove(key);
      return null;
    }
    return map[_data];
  }

  Future<Map?> getFullCache(String key) async {
    var result = (await preferences).getString(key);
    if (result == null) {
      return null;
    }
    Map<String, dynamic> map = jsonDecode(result);
    // if outdated, clear and return null
    var lastChecked = map[_lastChecked];
    var interval = map[_checkInterval];
    if ((DateTime.now().millisecondsSinceEpoch - lastChecked) > interval) {
      (await preferences).remove(key);
      return null;
    }
    return map;
  }

  Future saveValueDarkTheme({bool isDark = false}) async {
    (await preferences).setBool(_theme, isDark);
  }

  Future<bool> getValueDarkTheme() async {
    return (await preferences).getBool(_theme) ?? false;
  }
}
