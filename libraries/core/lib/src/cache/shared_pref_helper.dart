import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  final SharedPreferences preferences;
  SharedPrefHelper({required this.preferences});

  Future<bool> storeCacheList(String key, List<String> listJson) async {
    return preferences.setStringList(key, listJson);
  }

  List<String> getCacheList(String s) {
    return preferences.getStringList('getMovieTrailerById') ?? [];
  }
}
