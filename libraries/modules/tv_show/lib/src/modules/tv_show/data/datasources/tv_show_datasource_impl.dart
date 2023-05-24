import 'package:core/core.dart';

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
  final IHttpClient _httpClient;
  TvShowDatasourceImpl(this._httpClient);
  @override
  Future<List<TvShow>> getTvAiringToday() async {
    try {
      final response = await _httpClient.get('tv/airing_today');

      return MovieMapper.fromMapList(response.data);
    } on TimeOutError {
      throw CrewNoInternetConnection();
    } catch (e, stackTrace) {
      throw TvAiringTodayError(stackTrace, 'TvShowDatasourceImpl-getTvAiringToday', e, e.toString());
    }
  }

  @override
  Future<List<TvPopularShow>> getTvPopularShow() async {
    try {
      final response = await _httpClient.get('tv/popular');

      return TvPopularShowMapper.fromMapList(response.data);
    } on TimeOutError {
      throw CrewNoInternetConnection();
    } catch (e, stackTrace) {
      throw TvShowPopularError(stackTrace, 'TvShowDatasourceImpl-getTvPopularShow', e, e.toString());
    }
  }

  @override
  Future<List<OnTheAir>> getTvOnTheAir() async {
    try {
      final response = await _httpClient.get('tv/on_the_air');

      return TvOnTheAirMapper.fromMapList(response.data);
    } on TimeOutError {
      throw CrewNoInternetConnection();
    } catch (e, stackTrace) {
      throw TvOnTheAirError(stackTrace, 'TvShowDatasourceImpl-getTvOnTheAir', e, e.toString());
    }
  }

  @override
  Future<List<Crew>> getTvShowCrewById(int tvShowId) async {
    try {
      final response = await _httpClient.get('tv/$tvShowId/credits');

      return CrewMapper.fromMapList(response.data);
    } on TimeOutError {
      throw CrewNoInternetConnection();
    } catch (e, stackTrace) {
      throw CrewError(stackTrace, 'TvShowDatasourceImpl-getTvShowCrewById', e, e.toString());
    }
  }

  @override
  Future<List<Trailer>> getTvShowTrailerById(int tvShowId) async {
    try {
      final response = await _httpClient.get('tv/$tvShowId/videos');

      return TrailerMapper.fromMapList(response.data);
    } on TimeOutError {
      throw CrewNoInternetConnection();
    } catch (e, stackTrace) {
      throw CrewError(stackTrace, 'TvShowDatasourceImpl-getTvShowTrailerById', e, e.toString());
    }
  }

  @override
  Future<List<Crew>> getMovieCrew(int tvShowId) async {
    try {
      final response = await _httpClient.get('tv/$tvShowId/credits');

      return CrewMapper.fromMapList(response.data);
    } on TimeOutError {
      throw CrewNoInternetConnection();
    } catch (e, stackTrace) {
      throw CrewError(stackTrace, 'TvShowDatasourceImpl-getMovieCrew', e, e.toString());
    }
  }

  @override
  Future<List<Trailer>> getMovieTrailerById(int movieId) async {
    try {
      final response = await _httpClient.get('movie/$movieId/videos');

      return TrailerMapper.fromMapList(response.data);
    } on TimeOutError {
      throw CrewNoInternetConnection();
    } catch (e, stackTrace) {
      throw CrewError(stackTrace, 'TvShowDatasourceImpl-getMovieTrailerById', e, e.toString());
    }
  }
}
