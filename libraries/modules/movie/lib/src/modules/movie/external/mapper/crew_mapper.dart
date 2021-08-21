import '../../domain/entities/crew.dart';

class CrewMapper {
  static List<Crew> fromMapList(Map<String, dynamic> map) => List<Crew>.from((map['results'] ?? []).map(CrewMapper.fromMap));

  static Crew fromMap(dynamic map) {
    return Crew(
      map['name'],
      map['character'],
      map['profile_path'],
    );
  }
}
