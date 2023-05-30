import '../../domain/entities/trailer.dart';

class TrailerMapper {
  static List<Trailer> fromMapList(Map<String, dynamic> map) {
    if (map['results'] is List) {
      return List<Trailer>.from(
        (map['results'] as List).map((item) {
          return item is Map<String, dynamic> ? TrailerMapper.fromMap(item) : null;
        }).where((item) => item != null),
      );
    }

    return [];
  }

  static Trailer fromMap(Map<String, dynamic> map) {
    final String id = map['id'] ?? '';
    final String key = map['key'] ?? '';
    final String name = map['name'] ?? '';

    return Trailer(id, key, name);
  }
}
