import 'package:core/core.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/movie.dart';
import '../../domain/entities/on_the_air.dart';
import '../../domain/entities/tv_popular_show.dart';
import '../../domain/errors/airing_today_failures.dart';
import '../../infra/datasources/tv_show_datasource.dart';
import '../models/movie_mapper.dart';
import '../models/tv_on_the_air_mapper.dart';
import '../models/tv_popular_show_mapper.dart';

class TvShowDatasourceImpl implements ITvShowDatasource {
  final Dio dio;
  final ApiConfigurations configurations;

  TvShowDatasourceImpl(this.dio, this.configurations);
  @override
  Future<List<Movie>> getTvAiringToday() async {
    try {
      final response = await dio.get(
        'tv/airing_today',
        queryParameters: {
          'api_key': configurations.apiKey,
          'language': configurations.language,
        },
      );

      return MovieMapper.fromMapList(response.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
        throw TvAiringTodayNoInternetConnection();
      } else if (e.type == DioErrorType.other) {
        throw TvAiringTodayNoInternetConnection();
      } else {
        throw TvAiringTodayError(
          e.toString(),
        );
      }
    }
  }

  @override
  Future<List<TvPopularShow>> getTvPopularShow() async {
    try {
      final response = await dio.get(
        'tv/popular',
        queryParameters: {
          'api_key': configurations.apiKey,
          'language': configurations.language,
        },
      );

      return TvPopularShowMapper.fromMapList(response.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
        throw TvShowPopularNoInternetConnection();
      } else if (e.type == DioErrorType.other) {
        throw TvShowPopularNoInternetConnection();
      } else {
        throw TvShowPopularError(e.toString());
      }
    }
  }

  @override
  Future<List<OnTheAir>> getTvOnTheAir() async {
    try {
      final response = await dio.get(
        'tv/on_the_air',
        queryParameters: {
          'api_key': configurations.apiKey,
          'language': configurations.language,
        },
      );

      return TvOnTheAirMapper.fromMapList(response.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
        throw TvOnTheAirNoInternetConnection();
      } else if (e.type == DioErrorType.other) {
        throw TvOnTheAirNoInternetConnection();
      } else {
        throw TvOnTheAirError(e.toString());
      }
    }
  }
}
