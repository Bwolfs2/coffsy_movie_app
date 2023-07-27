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
    final String trailerId = map['id'] ?? '';
    final String key = map['key'] ?? '';
    final String name = map['name'] ?? 'No Name';

    return Trailer(trailerId, key, name);
  }

  static Map<String, dynamic> toMap(Trailer trailer) {
    return {
      'id': trailer.trailerId,
      'key': trailer.youtubeId,
      'name': trailer.title,
    };
  }
}
