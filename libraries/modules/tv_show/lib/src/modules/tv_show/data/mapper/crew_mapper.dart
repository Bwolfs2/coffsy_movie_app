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
}
