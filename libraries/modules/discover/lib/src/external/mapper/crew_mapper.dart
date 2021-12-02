// ignore_for_file: avoid_classes_with_only_static_members

import '../../domain/entities/crew.dart';

class CrewMapper {
  static List<Crew> fromMapList(Map<String, dynamic> map) => List<Crew>.from(
        (map['cast'] as List).where((element) => element['profile_path'] != null).map(CrewMapper.fromMap),
      );

  static Crew fromMap(dynamic map) {
    return Crew(
      map['name'],
      map['character'] ?? map['original_name'],
      map['profile_path'],
    );
  }

  static Map<dynamic, dynamic> toMap(Crew crew) {
    return {
      'name': crew.realName,
      'character': crew.characterName,
      'profile_path': crew.profile,
    };
  }
}
