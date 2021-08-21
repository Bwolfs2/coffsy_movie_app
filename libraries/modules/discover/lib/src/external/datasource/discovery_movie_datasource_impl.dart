import 'package:core/core.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/crew.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/trailer.dart';
import '../../domain/errors/discover_failures.dart';
import '../../infra/datasources/discovery_movie_datasource.dart';
import '../mapper/crew_mapper.dart';
import '../mapper/movie_mapper.dart';
import '../mapper/trailer_mapper.dart';

class DiscoveryMovieDatasourceImpl extends DiscoveryMovieDatasource {
  final Dio dio;
  final ApiConfigurations configurations;

  DiscoveryMovieDatasourceImpl(this.dio, this.configurations);

  @override
  Future<List<Movie>> getDiscoverMovie() async {
    try {
      final response = await dio.get(
        'discover/movie',
        queryParameters: {'api_key': configurations.apiKey, 'language': configurations.language},
      );

      return MovieMapper.fromMapList(response.data);
    } on DioError catch (e, stackTrace) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout || e.type == DioErrorType.other) {
        return [];
      } else {
        throw DiscoverMovieError(stackTrace, 'DiscoveryMovieDatasourceImpl-getMovieNowPlaying', e, e.toString());
      }
    }
  }

  @override
  Future<List<Trailer>> getMovieTrailerById(int movieId) async {
    try {
      final response = await dio.get('movie/$movieId/videos?api_key=${configurations.apiKey}&language=${configurations.language}');
      return TrailerMapper.fromMapList(response.data);
    } on DioError catch (e, stackTrace) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout || e.type == DioErrorType.other) {
        return [];
      } else {
        throw CrewError(stackTrace, 'DiscoveryMovieDatasourceImpl-getTvShowTrailerById', e, e.toString());
      }
    }
  }

  @override
  Future<List<Trailer>> getTvShowTrailerById(int tvShowId) async {
    try {
      final response = await dio.get('tv/$tvShowId/videos?api_key=${configurations.apiKey}&language=${configurations.language}');
      return TrailerMapper.fromMapList(response.data);
    } on DioError catch (e, stackTrace) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout || e.type == DioErrorType.other) {
        return [];
      } else {
        throw CrewError(stackTrace, 'DiscoveryMovieDatasourceImpl-getTvShowTrailerById', e, e.toString());
      }
    }
  }

  @override
  Future<List<Crew>> getMovieCrew(int movieId) async {
    try {
      final response = await dio.get('movie/$movieId/credits?api_key=${configurations.apiKey}&language=${configurations.language}');

      return CrewMapper.fromMapList(response.data);
    } on DioError catch (e, stackTrace) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout || e.type == DioErrorType.other) {
        return [];
      } else {
        throw CrewError(stackTrace, 'DiscoveryMovieDatasourceImpl-getMovieCrew', e, e.toString());
      }
    }
  }

  @override
  Future<List<Crew>> getTvShowCrewById(int tvShowId) async {
    try {
      final response = await dio.get('tv/$tvShowId/credits?api_key=${configurations.apiKey}&language=${configurations.language}');

      return CrewMapper.fromMapList(response.data);
    } on DioError catch (e, stackTrace) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout || e.type == DioErrorType.other) {
        return [];
      } else {
        throw CrewError(stackTrace, 'DiscoveryMovieDatasourceImpl-getTvShowCrewById', e, e.toString());
      }
    }
  }
}
