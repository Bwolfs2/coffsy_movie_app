import 'dart:convert';

import 'package:core/core.dart';

import '../../domain/entities/crew.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/trailer.dart';
import '../../infra/datasources/discovery_movie_local_datasource.dart';
import '../mapper/crew_mapper.dart';
import '../mapper/movie_mapper.dart';
import '../mapper/trailer_mapper.dart';

class DiscoveryMovieLocalDatasourceImpl extends DiscoveryMovieLocalDatasource {
  final SharedPrefHelper shared;

  DiscoveryMovieLocalDatasourceImpl(this.shared);

  @override
  Future<List<Movie>> getDiscoverMovie() async {
    final discoverMovie = shared.getCacheList('getDiscoverMovie');
    if (discoverMovie.isEmpty) {
      return discoverMovie.map((e) => MovieMapper.fromMap(json.decode(e))).toList();
    }

    return [];
  }

  @override
  Future<List<Trailer>> getMovieTrailerById(int movieId) async {
    final movieTrailer = shared.getCacheList('getMovieTrailerById');
    if (movieTrailer.isEmpty) {
      return movieTrailer.map((e) => TrailerMapper.fromMap(json.decode(e))).toList();
    }

    return [];
  }

  @override
  Future<List<Trailer>> getTvShowTrailerById(int tvShowId) async {
    final tvShowTrailer = shared.getCacheList('getTvShowTrailerById');
    if (tvShowTrailer.isEmpty) {
      return tvShowTrailer.map((e) => TrailerMapper.fromMap(json.decode(e))).toList();
    }

    return [];
  }

  @override
  Future<List<Crew>> getMovieCrew(int movieId) async {
    final movieCrew = shared.getCacheList('getMovieCrew');
    if (movieCrew.isEmpty) {
      return movieCrew.map((e) => CrewMapper.fromMap(json.decode(e))).toList();
    }

    return [];
  }

  @override
  Future<List<Crew>> getTvShowCrewById(int tvShowId) async {
    final tvShowCrew = shared.getCacheList('getTvShowCrewById');
    if (tvShowCrew.isEmpty) {
      return tvShowCrew.map((e) => CrewMapper.fromMap(json.decode(e))).toList();
    }

    return [];
  }

  @override
  void setDiscoverMovie(List<Movie> data) {
    shared.storeCacheList('getDiscoverMovie', data.map((e) => json.encode(MovieMapper.toMap(e))).toList());
  }

  @override
  void setMovieCrew(List<Crew> data) {
    shared.storeCacheList('getMovieCrew', data.map((e) => json.encode(CrewMapper.toMap(e))).toList());
  }

  @override
  void setMovieTrailerById(List<Trailer> data) {
    shared.storeCacheList('getMovieTrailerById', data.map((e) => json.encode(TrailerMapper.toMap(e))).toList());
  }

  @override
  void setTvShowCrewById(List<Crew> data) {
    shared.storeCacheList('getTvShowCrewById', data.map((e) => json.encode(CrewMapper.toMap(e))).toList());
  }

  @override
  void setTvShowTrailerById(List<Trailer> data) {
    shared.storeCacheList('getTvShowTrailerById', data.map((e) => json.encode(TrailerMapper.toMap(e))).toList());
  }
}
