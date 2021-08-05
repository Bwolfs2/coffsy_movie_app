import 'package:core/core.dart' hide Crew, Trailer;
import 'package:dio/dio.dart';

import '../../domain/entities/crew.dart';
import '../../domain/entities/on_the_air.dart';
import '../../domain/entities/trailer.dart';
import '../../domain/entities/tv_popular_show.dart';
import '../../domain/entities/tv_show.dart';
import '../../domain/errors/tv_show_failures.dart';
import '../../infra/datasources/tv_show_datasource.dart';
import '../mapper/crew_mapper.dart';
import '../mapper/movie_mapper.dart';
import '../mapper/trailer_mapper.dart';
import '../mapper/tv_on_the_air_mapper.dart';
import '../mapper/tv_popular_show_mapper.dart';

class TvShowDatasourceImpl implements ITvShowDatasource {
  final Dio dio;
  final ApiConfigurations configurations;

  TvShowDatasourceImpl(this.dio, this.configurations);
  @override
  Future<List<TvShow>> getTvAiringToday() async {
    try {
      final response = await dio.get(
        'tv/airing_today',
        queryParameters: {
          'api_key': configurations.apiKey,
          'language': configurations.language,
        },
      );

      return MovieMapper.fromMapList(response.data);
    } on DioError catch (e, stackTrace) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
        throw TvAiringTodayNoInternetConnection();
      } else if (e.type == DioErrorType.other) {
        throw TvAiringTodayNoInternetConnection();
      } else {
        throw TvAiringTodayError(stackTrace, 'TvShowDatasourceImpl-getTvAiringToday', e, e.toString());
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
    } on DioError catch (e, stackTrace) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
        throw TvShowPopularNoInternetConnection();
      } else if (e.type == DioErrorType.other) {
        throw TvShowPopularNoInternetConnection();
      } else {
        throw TvShowPopularError(stackTrace, 'TvShowDatasourceImpl-getTvPopularShow', e, e.toString());
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
    } on DioError catch (e, stackTrace) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
        throw TvOnTheAirNoInternetConnection();
      } else if (e.type == DioErrorType.other) {
        throw TvOnTheAirNoInternetConnection();
      } else {
        throw TvOnTheAirError(stackTrace, 'TvShowDatasourceImpl-getTvOnTheAir', e, e.toString());
      }
    }
  }

  @override
  Future<List<Crew>> getTvShowCrewById(int tvShowId) async {
    try {
      final response = await dio.get('tv/$tvShowId/credits?api_key=${configurations.apiKey}&language=${configurations.language}');

      return CrewMapper.fromMapList(response.data);
    } on DioError catch (e, stackTrace) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
        throw CrewNoInternetConnection();
      } else if (e.type == DioErrorType.other) {
        throw CrewNoInternetConnection();
      } else {
        throw CrewError(stackTrace, 'TvShowDatasourceImpl-getTvShowCrewById', e, e.toString());
      }
    }
  }

  @override
  Future<List<Trailer>> getTvShowTrailerById(int tvShowId) async {
    try {
      final response = await dio.get('tv/$tvShowId/videos?api_key=${configurations.apiKey}&language=${configurations.language}');
      return TrailerMapper.fromMapList(response.data);
    } on DioError catch (e, stackTrace) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
        throw CrewNoInternetConnection();
      } else if (e.type == DioErrorType.other) {
        throw CrewNoInternetConnection();
      } else {
        throw CrewError(stackTrace, 'TvShowDatasourceImpl-getTvShowTrailerById', e, e.toString());
      }
    }
  }

  @override
  Future<List<Crew>> getMovieCrew(int tvShowId) async {
    try {
      final response = await dio.get('tv/$tvShowId/credits?api_key=${configurations.apiKey}&language=${configurations.language}');

      return CrewMapper.fromMapList(response.data);
    } on DioError catch (e, stackTrace) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
        throw CrewNoInternetConnection();
      } else if (e.type == DioErrorType.other) {
        throw CrewNoInternetConnection();
      } else {
        throw CrewError(stackTrace, 'TvShowDatasourceImpl-getTvShowCrewById', e, e.toString());
      }
    }
  }

  @override
  Future<List<Trailer>> getMovieTrailerById(int movieId) async {
    try {
      final response = await dio.get('movie/$movieId/videos?api_key=${configurations.apiKey}&language=${configurations.language}');
      return TrailerMapper.fromMapList(response.data);
    } on DioError catch (e, stackTrace) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
        throw CrewNoInternetConnection();
      } else if (e.type == DioErrorType.other) {
        throw CrewNoInternetConnection();
      } else {
        throw CrewError(stackTrace, 'TvShowDatasourceImpl-getTvShowTrailerById', e, e.toString());
      }
    }
  }
}
