import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';

class SettingStore extends StreamStore<Failure, bool> {
  static SettingStore? _instance;

  static SettingStore get getInstance => _instance ??= SettingStore._(prefHelper: SharedPrefHelper());

  final SharedPrefHelper prefHelper;

  SettingStore._({required this.prefHelper}) : super(false) {
    loadTheme();
  }

  factory SettingStore() => getInstance;

  Future<void> changeTheme(bool isDark) async {
    setLoading(true);
    await prefHelper.saveValueDarkTheme(isDark);
    update(isDark, force: true);
    setLoading(false);
  }

  Future<void> loadTheme() async {
    setLoading(true);
    final isDark = await prefHelper.getValueDarkTheme();
    update(isDark, force: true);
    setLoading(false);
  }
}
