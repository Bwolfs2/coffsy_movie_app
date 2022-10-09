import 'package:dio/dio.dart';

import '../../domain/entities/crew.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/trailer.dart';
import '../../domain/errors/movie_failures.dart';
import '../../infra/data_sources/movie_data_source.dart';
import '../mapper/crew_mapper.dart';
import '../mapper/movie_mapper.dart';
import '../mapper/trailer_mapper.dart';

class MovieDataSourceImpl implements MovieDataSource {
  final Dio dio;

  MovieDataSourceImpl(this.dio);

  @override
  Future<List<Movie>> getMovieNowPlaying() async {
    try {
      final response = await dio.get(
        'movie/now_playing',
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
      final response = await dio.get('movie/popular');
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
      final response = await dio.get('movie/upcoming');
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

  @override
  Future<List<Trailer>> getMovieTrailerById(int movieId) async {
    try {
      final response = await dio.get('movie/$movieId/videos');
      return TrailerMapper.fromMapList(response.data);
    } on DioError catch (e, stackTrace) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
        throw TrailerNoInternetConnection();
      } else if (e.type == DioErrorType.other) {
        throw TrailerNoInternetConnection();
      } else {
        throw TrailerError(stackTrace, 'MovieDataSourceImpl-getMovieTrailerById', e, e.toString());
      }
    }
  }

  @override
  Future<List<Trailer>> getTvShowTrailerById(int tvId) async {
    try {
      final response = await dio.get('tv/$tvId/videos');
      return TrailerMapper.fromMapList(response.data);
    } on DioError catch (e, stackTrace) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
        throw TrailerNoInternetConnection();
      } else if (e.type == DioErrorType.other) {
        throw TrailerNoInternetConnection();
      } else {
        throw TrailerError(stackTrace, 'MovieDataSourceImpl-getTvShowTrailerById', e, e.toString());
      }
    }
  }

  @override
  Future<List<Crew>> getMovieCrewById(int movieId) async {
    try {
      final response = await dio.get('movie/$movieId/credits');
      return CrewMapper.fromMapList(response.data);
    } on DioError catch (e, stackTrace) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
        throw CrewNoInternetConnection();
      } else if (e.type == DioErrorType.other) {
        throw CrewNoInternetConnection();
      } else {
        throw CrewError(stackTrace, 'MovieDataSourceImpl-getMovieCrewById', e, e.toString());
      }
    }
  }

  @override
  Future<List<Crew>> getTvShowCrewById(int tvId) async {
    try {
      final response = await dio.get('tv/$tvId/credits');
      return CrewMapper.fromMapList(response.data);
    } on DioError catch (e, stackTrace) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
        throw CrewNoInternetConnection();
      } else if (e.type == DioErrorType.other) {
        throw CrewNoInternetConnection();
      } else {
        throw CrewError(stackTrace, 'MovieDataSourceImpl-getTvShowCrewById', e, e.toString());
      }
    }
  }
}
