import '../../domain/entities/crew.dart';

class CrewMapper {
  static List<Crew> fromMapList(Map<String, dynamic> map) {
    if (map['cast'] is List) {
      return List<Crew>.from(
        (map['cast'] as List)
            .where(
          (item) => item is Map<String, dynamic> && item['name'] != null && item['character'] != null && item['profile_path'] != null,
        )
            .map((item) {
          return item is Map<String, dynamic> ? CrewMapper.fromMap(item) : null;
        }).where((item) => item != null),
      );
    }

    return [];
  }

  static Crew fromMap(dynamic map) {
    final String name = map['name'] ?? '';
    final String character = map['character'] ?? map['original_name'] ?? '';
    final String profilePath = map['profile_path'] ?? '';

    return Crew(name, character, profilePath);
  }
}
