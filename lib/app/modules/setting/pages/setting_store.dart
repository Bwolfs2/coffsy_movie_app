import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingStore extends StreamStore<Failure, bool> {
  static SettingStore? _instance;

  factory SettingStore() => _instance ??= SettingStore._();

  SettingStore._() : super(false) {
    loadTheme();
  }

  Future<void> changeTheme({bool isDark = false}) async {
    setLoading(true);
    await saveValueDarkTheme(isDark: isDark);
    update(isDark, force: true);
    setLoading(false);
  }

  Future<void> loadTheme() async {
    setLoading(true);
    final isDark = await getValueDarkTheme();
    update(isDark, force: true);
    setLoading(false);
  }

  final String _theme = 'theme';

  Future saveValueDarkTheme({bool isDark = false}) async {
    final shared = await SharedPreferences.getInstance();
    await shared.setBool(_theme, isDark);
  }

  Future<bool> getValueDarkTheme() async {
    final shared = await SharedPreferences.getInstance();

    return shared.getBool(_theme) ?? false;
  }
}
