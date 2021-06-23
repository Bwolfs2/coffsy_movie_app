// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    (json['results'] as List<dynamic>).map((e) => Movies.fromJson(e as Map<String, dynamic>)).toList(),
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'results': instance.results,
    };

Movies _$MoviesFromJson(Map<String, dynamic> json) {
  return Movies(
    json['id'] as int,
    json['title'] ?? json['name'] as String,
    json['overview'] as String,
    json['release_date'] ?? 'No Release Date',
    (json['genre_ids'] as List<dynamic>).map((e) => e as int).toList(),
    (json['vote_average'] as num).toDouble(),
    (json['popularity'] as num).toDouble(),
    json['poster_path'] as String,
    json['backdrop_path'] ?? json['poster_path'] as String,
    json['original_name'] as String? ?? 'No TV Name',
    json['first_air_date'] as String? ?? 'No TV Name',
  );
}

Map<String, dynamic> _$MoviesToJson(Movies instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'overview': instance.overview,
      'release_date': instance.releaseDate,
      'genre_ids': instance.genreIds,
      'vote_average': instance.voteAverage,
      'popularity': instance.popularity,
      'poster_path': instance.posterPath,
      'backdrop_path': instance.backdropPath,
      'original_name': instance.tvName,
      'first_air_date': instance.tvRelease,
    };
