import '../../domain/entities/trailer.dart';

// ignore: avoid_classes_with_only_static_members
class TrailerMapper {
  static List<Trailer> fromMapList(Map<String, dynamic> map) => List<Trailer>.from(
        (map['results'] as List).map(TrailerMapper.fromMap),
      );

  static Trailer fromMap(dynamic map) {
    return Trailer(
      map['id'],
      map['key'],
      map['name'] ?? 'No Name',
    );
  }

  static Map<dynamic, dynamic> toMap(Trailer trailer) {
    return {
      'id': trailer.trailerId,
      'key': trailer.youtubeId,
      'name': trailer.title,
    };
  }
}
