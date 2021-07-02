import '../../domain/entities/trailer.dart';

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
}
