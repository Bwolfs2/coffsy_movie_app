import 'package:core/core.dart';

import '../../domain/entities/crew.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/trailer.dart';
import '../../domain/errors/movie_failures.dart';
import '../../infra/data_sources/movie_data_source.dart';
import '../mapper/crew_mapper.dart';
import '../mapper/movie_mapper.dart';
import '../mapper/trailer_mapper.dart';

class MovieDataSourceImpl implements MovieDataSource {
  final IHttpClient _httpClient;

  MovieDataSourceImpl(this._httpClient);

  @override
  Future<List<Movie>> getMovieNowPlaying() async {
    try {
      final response = await _httpClient.get(
        'movie/now_playing',
      );

      return MovieMapper.fromMapList(response.data);
    } on Failure catch (e, stackTrace) {
      if (e is TimeOutError) {
        throw MovieNowPlayingNoInternetConnection();
      } else {
        throw MovieNowPlayingError(stackTrace, 'MovieDataSourceImpl-getMovieNowPlaying', e, e.toString());
      }
    }
  }

  @override
  Future<List<Movie>> getMoviePopular() async {
    try {
      final response = await _httpClient.get('movie/popular');

      return MovieMapper.fromMapList(response.data);
    } on TimeOutError {
      throw MovieUpComingNoInternetConnection();
    } catch (e, stackTrace) {
      throw MoviePopularError(stackTrace, 'MovieDataSourceImpl-getMoviePopular', e, e.toString());
    }
  }

  @override
  Future<List<Movie>> getMovieUpComming() async {
    try {
      final response = await _httpClient.get('movie/upcoming');

      return MovieMapper.fromMapList(response.data);
    } on TimeOutError {
      throw MovieUpComingNoInternetConnection();
    } catch (e, stackTrace) {
      throw MovieUpComingError(stackTrace, 'MovieDataSourceImpl-getMovieUpComming', e, e.toString());
    }
  }

  @override
  Future<List<Trailer>> getMovieTrailerById(int movieId) async {
    try {
      final response = await _httpClient.get('movie/$movieId/videos');

      return TrailerMapper.fromMapList(response.data);
    } on TimeOutError {
      throw MovieUpComingNoInternetConnection();
    } catch (e, stackTrace) {
      throw TrailerError(stackTrace, 'MovieDataSourceImpl-getMovieTrailerById', e, e.toString());
    }
  }

  @override
  Future<List<Trailer>> getTvShowTrailerById(int tvId) async {
    try {
      final response = await _httpClient.get('tv/$tvId/videos');

      return TrailerMapper.fromMapList(response.data);
    } on TimeOutError {
      throw MovieUpComingNoInternetConnection();
    } catch (e, stackTrace) {
      throw TrailerError(stackTrace, 'MovieDataSourceImpl-getTvShowTrailerById', e, e.toString());
    }
  }

  @override
  Future<List<Crew>> getMovieCrewById(int movieId) async {
    try {
      final response = await _httpClient.get('movie/$movieId/credits');

      return CrewMapper.fromMapList(response.data);
    } on TimeOutError {
      throw MovieUpComingNoInternetConnection();
    } catch (e, stackTrace) {
      throw CrewError(stackTrace, 'MovieDataSourceImpl-getMovieCrewById', e, e.toString());
    }
  }

  @override
  Future<List<Crew>> getTvShowCrewById(int tvId) async {
    try {
      final response = await _httpClient.get('tv/$tvId/credits');

      return CrewMapper.fromMapList(response.data);
    } on TimeOutError {
      throw MovieUpComingNoInternetConnection();
    } catch (e, stackTrace) {
      throw CrewError(stackTrace, 'MovieDataSourceImpl-getTvShowCrewById', e, e.toString());
    }
  }
}
