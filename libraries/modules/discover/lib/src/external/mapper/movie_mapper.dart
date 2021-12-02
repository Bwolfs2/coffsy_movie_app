// ignore_for_file: avoid_classes_with_only_static_members

import '../../domain/entities/movie.dart';

class MovieMapper {
  static List<Movie> fromMapList(Map<String, dynamic> map) => List<Movie>.from((map['results'] as List).map(MovieMapper.fromMap));

  static Movie fromMap(dynamic map) {
    return Movie(
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

  static Map<dynamic, dynamic> toMap(Movie crew) {
    return {
      'id': crew.id,
      'title': crew.title,
      'overview': crew.overview,
      'release_date': crew.releaseDate,
      'genre_ids': crew.genreIds.map((e) => e).toList(),
      'vote_average': crew.voteAverage,
      'popularity': crew.popularity,
      'poster_path': crew.posterPath,
      'backdrop_path': crew.backdropPath,
      'tv_name': crew.tvName,
      'tv_release': crew.tvRelease,
    };
  }
}
