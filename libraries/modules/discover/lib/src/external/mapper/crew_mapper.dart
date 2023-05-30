// ignore_for_file: avoid_classes_with_only_static_members

import '../../domain/entities/crew.dart';

class CrewMapper {
  static List<Crew> fromMapList(Map<String, dynamic> map) {
    if (map['cast'] is List) {
      return List<Crew>.from(
        (map['cast'] as List).map((item) {
          return item is Map<String, dynamic> && item['profile_path'] != null ? CrewMapper.fromMap(item) : null;
        }).where((item) => item != null),
      );
    }

    return [];
  }

  static Crew fromMap(Map<String, dynamic> map) {
    final String name = map['name'] ?? '';
    final String character = map['character'] ?? map['original_name'] ?? '';
    final String profilePath = map['profile_path'] ?? '';

    return Crew(
      name,
      character,
      profilePath,
    );
  }

  static Map<String, dynamic> toMap(Crew crew) {
    return {
      'name': crew.realName,
      'character': crew.characterName,
      'profile_path': crew.profile,
    };
  }
}
