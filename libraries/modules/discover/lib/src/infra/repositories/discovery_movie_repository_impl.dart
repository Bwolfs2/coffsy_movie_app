import 'package:core/core.dart';

import '../../domain/entities/crew.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/trailer.dart';
import '../../domain/errors/discover_failures.dart';
import '../../domain/repositories/discovery_movie_repository.dart';
import '../datasources/discovery_movie_datasource.dart';
import '../datasources/discovery_movie_local_datasource.dart';

class DiscoveryMovieRepositoryImpl implements IDiscoveryMovieRepository {
  final DiscoveryMovieDatasource _discoveryMovieDatasource;
  final DiscoveryMovieLocalDatasource _discoveryMovieLocalDatasource;

  DiscoveryMovieRepositoryImpl(this._discoveryMovieDatasource, this._discoveryMovieLocalDatasource);

  @override
  Stream<List<Movie>> getDiscoverMovie() async* {
    try {
      var localData = await _discoveryMovieLocalDatasource.getDiscoverMovie();
      yield localData;
      var data = await _discoveryMovieDatasource.getDiscoverMovie();
      if (data.isNotEmpty) {
        _discoveryMovieLocalDatasource.setDiscoverMovie(data);
        yield data;
      }
      if (localData.isEmpty && data.isEmpty) {
        yield* Stream.error(NoDataFound());
      }
    } on Failure catch (e) {
      yield* Stream.error(e);
    }
  }

  @override
  Stream<List<Trailer>> getMovieTrailerById(int id) async* {
    try {
      var localData = await _discoveryMovieLocalDatasource.getMovieTrailerById(id);
      yield localData;
      var data = await _discoveryMovieDatasource.getMovieTrailerById(id);
      if (data.isNotEmpty) {
        _discoveryMovieLocalDatasource.setMovieTrailerById(data);
        yield data;
      }
      if (localData.isEmpty && data.isEmpty) {
        yield* Stream.error(NoDataFound());
      }
    } on Failure catch (e) {
      yield* Stream.error(e);
    }
  }

  @override
  Stream<List<Trailer>> getTvShowTrailerById(int movieId) async* {
    try {
      var localData = await _discoveryMovieLocalDatasource.getTvShowTrailerById(movieId);
      yield localData;

      var data = await _discoveryMovieDatasource.getTvShowTrailerById(movieId);
      if (data.isNotEmpty) {
        _discoveryMovieLocalDatasource.setTvShowTrailerById(data);
        yield data;
      }
      if (localData.isEmpty && data.isEmpty) {
        yield* Stream.error(NoDataFound());
      }
    } on Failure catch (e) {
      yield* Stream.error(e);
    }
  }

  @override
  Stream<List<Crew>> getMovieCrew(int id) async* {
    try {
      var localData = await _discoveryMovieLocalDatasource.getMovieCrew(id);
      yield localData;
      var data = await _discoveryMovieDatasource.getMovieCrew(id);
      if (data.isNotEmpty) {
        _discoveryMovieLocalDatasource.setMovieCrew(data);
        yield data;
      }
      if (localData.isEmpty && data.isEmpty) {
        yield* Stream.error(NoDataFound());
      }
    } on Failure catch (e) {
      yield* Stream.error(e);
    }
  }

  @override
  Stream<List<Crew>> getTvShowCrewById(int movieId) async* {
    try {
      var localData = await _discoveryMovieLocalDatasource.getTvShowCrewById(movieId);
      yield localData;
      var data = await _discoveryMovieDatasource.getTvShowCrewById(movieId);
      if (data.isNotEmpty) {
        _discoveryMovieLocalDatasource.setTvShowCrewById(data);
        yield data;
      }
      if (localData.isEmpty && data.isEmpty) {
        yield* Stream.error(NoDataFound());
      }
    } on Failure catch (e) {
      yield* Stream.error(e);
    }
  }
}
