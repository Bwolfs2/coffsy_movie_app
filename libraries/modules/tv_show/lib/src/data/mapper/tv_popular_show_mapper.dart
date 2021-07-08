import '../../domain/entities/tv_popular_show.dart';

class TvPopularShowMapper {
  static List<TvPopularShow> fromMapList(Map<String, dynamic> map) =>
      List<TvPopularShow>.from((map['results'] as List).map(TvPopularShowMapper.fromMap));

  static TvPopularShow fromMap(dynamic map) {
    return TvPopularShow(
      map['id'],
      map['title'] ?? map['name'],
      map['overview'],
      map['release_date'] ?? 'No Release Date',
      List<int>.from(map['genre_ids']),
      (map['vote_average'] as num).toDouble(),
      (map['popularity'] as num).toDouble(),
      map['poster_path'] == null ? '' : map['poster_path'] as String,
      map['backdrop_path'] != null
          ? map['backdrop_path'] as String
          : map['poster_path'] == null
              ? ''
              : map['poster_path'] as String,
      map['tv_name'] ?? map['original_name'],
      map['tv_release'],
    );
  }
}
