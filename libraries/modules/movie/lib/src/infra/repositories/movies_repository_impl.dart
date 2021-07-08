import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/movie.dart';
import '../../domain/errors/movie_failures.dart';
import '../../domain/repositories/movies_repository.dart';
import '../data_sources/movie_data_source.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MovieDataSource _dataSource;

  MoviesRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<Movie>>> getMovieNowPlaying() async {
    try {
      var result = await _dataSource.getMovieNowPlaying();

      if (result.isEmpty) {
        return Left(NoDataFound());
      }

      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } on Exception catch (exception, stacktrace) {
      return Left(UnknownError(error: exception, stackTrace: stacktrace));
      // ignore: avoid_catches_without_on_clauses
    } catch (e, st) {
      return Left(UnknownError(error: e, stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getMoviePopular() async {
    try {
      var result = await _dataSource.getMoviePopular();

      if (result.isEmpty) {
        return Left(NoDataFound());
      }

      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } on Exception catch (exception, stacktrace) {
      return Left(UnknownError(error: exception, stackTrace: stacktrace));
      // ignore: avoid_catches_without_on_clauses
    } catch (e, st) {
      return Left(UnknownError(error: e, stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getMovieUpComming() async {
    try {
      var result = await _dataSource.getMovieUpComming();

      if (result.isEmpty) {
        return Left(NoDataFound());
      }

      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } on Exception catch (exception, stacktrace) {
      return Left(UnknownError(error: exception, stackTrace: stacktrace));
      // ignore: avoid_catches_without_on_clauses
    } catch (e, st) {
      return Left(UnknownError(error: e, stackTrace: st));
    }
  }
}
