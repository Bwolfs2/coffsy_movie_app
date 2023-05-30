// ignore_for_file: avoid_classes_with_only_static_members

import '../../domain/entities/movie.dart';

class MovieMapper {
  static List<Movie> fromMapList(Map<String, dynamic> map) {
    if (map['results'] is List) {
      return List<Movie>.from(
        (map['results'] as List).map((item) {
          return item is Map<String, dynamic> ? MovieMapper.fromMap(item) : null;
        }).where((item) => item != null),
      );
    }

    return [];
  }

  static Movie fromMap(Map<String, dynamic> map) {
    final int id = map['id'] ?? 0;
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

    return Movie(
      id,
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

  static Map<String, dynamic> toMap(Movie movie) {
    return {
      'id': movie.id,
      'title': movie.title,
      'overview': movie.overview,
      'release_date': movie.releaseDate,
      'genre_ids': movie.genreIds,
      'vote_average': movie.voteAverage,
      'popularity': movie.popularity,
      'poster_path': movie.posterPath,
      'backdrop_path': movie.backdropPath,
      'tv_name': movie.tvName,
      'tv_release': movie.tvRelease,
    };
  }
}
