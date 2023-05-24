import 'package:core/core.dart';

import '../../domain/entities/crew.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/trailer.dart';
import '../../domain/errors/discover_failures.dart';
import '../../infra/datasources/discovery_movie_datasource.dart';
import '../mapper/crew_mapper.dart';
import '../mapper/movie_mapper.dart';
import '../mapper/trailer_mapper.dart';

class DiscoveryMovieDatasourceImpl extends DiscoveryMovieDatasource {
  final IHttpClient _httpClient;
  DiscoveryMovieDatasourceImpl(this._httpClient);

  @override
  Future<List<Movie>> getDiscoverMovie() async {
    try {
      final response = await _httpClient.get(
        'discover/movie',
      );

      return MovieMapper.fromMapList(response.data);
    } on TimeOutError {
      return [];
    } catch (e, stackTrace) {
      throw DiscoverMovieError(stackTrace, 'DiscoveryMovieDatasourceImpl-getMovieNowPlaying', e, e.toString());
    }
  }

  @override
  Future<List<Trailer>> getMovieTrailerById(int movieId) async {
    try {
      final response = await _httpClient.get('movie/$movieId/videos');

      return TrailerMapper.fromMapList(response.data);
    } on TimeOutError {
      return [];
    } catch (e, stackTrace) {
      throw CrewError(stackTrace, 'DiscoveryMovieDatasourceImpl-getTvShowTrailerById', e, e.toString());
    }
  }

  @override
  Future<List<Trailer>> getTvShowTrailerById(int tvShowId) async {
    try {
      final response = await _httpClient.get('tv/$tvShowId/videos');

      return TrailerMapper.fromMapList(response.data);
    } on TimeOutError {
      return [];
    } catch (e, stackTrace) {
      throw CrewError(stackTrace, 'DiscoveryMovieDatasourceImpl-getTvShowTrailerById', e, e.toString());
    }
  }

  @override
  Future<List<Crew>> getMovieCrew(int movieId) async {
    try {
      final response = await _httpClient.get('movie/$movieId/credits');

      return CrewMapper.fromMapList(response.data);
    } on TimeOutError {
      return [];
    } catch (e, stackTrace) {
      throw CrewError(stackTrace, 'DiscoveryMovieDatasourceImpl-getMovieCrew', e, e.toString());
    }
  }

  @override
  Future<List<Crew>> getTvShowCrewById(int tvShowId) async {
    try {
      final response = await _httpClient.get('tv/$tvShowId/credits');

      return CrewMapper.fromMapList(response.data);
    } on TimeOutError {
      return [];
    } catch (e, stackTrace) {
      throw CrewError(stackTrace, 'DiscoveryMovieDatasourceImpl-getTvShowCrewById', e, e.toString());
    }
  }
}
