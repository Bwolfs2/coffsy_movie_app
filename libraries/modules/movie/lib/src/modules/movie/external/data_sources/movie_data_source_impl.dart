import 'package:core/core.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/movie.dart';
import '../../domain/errors/movie_failures.dart';
import '../../infra/data_sources/movie_data_source.dart';
import '../mapper/movie_mapper.dart';

class MovieDataSourceImpl implements MovieDataSource {
  final Dio dio;
  final ApiConfigurations configurations;

  MovieDataSourceImpl(this.dio, this.configurations);

  @override
  Future<List<Movie>> getMovieNowPlaying() async {
    try {
      final response = await dio.get(
        'movie/now_playing',
        queryParameters: {'api_key': configurations.apiKey, 'language': configurations.language},
      );

      return MovieMapper.fromMapList(response.data);
    } on DioError catch (e, stackTrace) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
        throw MovieNowPlayingNoInternetConnection();
      } else if (e.type == DioErrorType.other) {
        throw MovieNowPlayingNoInternetConnection();
      } else {
        throw MovieNowPlayingError(stackTrace, 'MovieDataSourceImpl-getMovieNowPlaying', e, e.toString());
      }
    }
  }

  @override
  Future<List<Movie>> getMoviePopular() async {
    try {
      final response = await dio.get(
        'movie/popular',
        queryParameters: {'api_key': configurations.apiKey, 'language': configurations.language},
      );
      return MovieMapper.fromMapList(response.data);
    } on DioError catch (e, stackTrace) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
        throw MoviePopularNoInternetConnection();
      } else if (e.type == DioErrorType.other) {
        throw MoviePopularNoInternetConnection();
      } else {
        throw MoviePopularError(stackTrace, 'MovieDataSourceImpl-getMoviePopular', e, e.toString());
      }
    }
  }

  @override
  Future<List<Movie>> getMovieUpComming() async {
    try {
      final response = await dio.get(
        'movie/upcoming',
        queryParameters: {'api_key': configurations.apiKey, 'language': configurations.language},
      );
      return MovieMapper.fromMapList(response.data);
    } on DioError catch (e, stackTrace) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
        throw MovieUpComingNoInternetConnection();
      } else if (e.type == DioErrorType.other) {
        throw MovieUpComingNoInternetConnection();
      } else {
        throw MovieUpComingError(stackTrace, 'MovieDataSourceImpl-getMovieUpComming', e, e.toString());
      }
    }
  }
}
