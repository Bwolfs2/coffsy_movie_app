import '../../domain/entities/tv_popular_show.dart';

class TvPopularShowMapper {
  static List<TvPopularShow> fromMapList(Map<String, dynamic> map) {
    if (map['results'] is List) {
      return List<TvPopularShow>.from(
        (map['results'] as List).map((item) {
          return item is Map<String, dynamic> ? TvPopularShowMapper.fromMap(item) : null;
        }).where((item) => item != null),
      );
    }

    return [];
  }

  static TvPopularShow fromMap(Map<String, dynamic> map) {
    final String title = map['title'] ?? map['name'] ?? '';
    final String overview = map['overview'] ?? '';
    final String releaseDate = map['release_date'] ?? 'No Release Date';
    final genreIds = map['genre_ids'] is List<int> ? List<int>.from(map['genre_ids']) : <int>[];
    final voteAverage = (map['vote_average'] as num?)?.toDouble() ?? 0;
    final popularity = (map['popularity'] as num?)?.toDouble() ?? 0;
    final posterPath = map['poster_path'] as String? ?? '';
    final backdropPath = map['backdrop_path'] as String? ?? posterPath;
    final String tvName = map['tv_name'] ?? map['original_name'] ?? '';
    final String tvRelease = map['tv_release'] ?? '';

    return TvPopularShow(
      map['id'],
      title,
      overview,
      releaseDate,
      genreIds,
      voteAverage,
      popularity,
      posterPath,
      backdropPath,
      tvName,
      tvRelease,
    );
  }
}
