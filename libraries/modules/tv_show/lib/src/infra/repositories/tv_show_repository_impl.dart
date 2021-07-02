import 'package:core/core.dart';

import '../../domain/entities/movie.dart';
import '../../domain/entities/on_the_air.dart';
import '../../domain/entities/tv_popular_show.dart';
import '../../domain/repositories/tv_show_repository.dart';
import '../datasources/tv_show_datasource.dart';

class TvShowRepositoryImpl implements ITvShowRepository {
  final ITvShowDatasource datasource;

  TvShowRepositoryImpl(this.datasource);
  @override
  Future<List<Movie>> getTvAiringToday() {
    try {
      return datasource.getTvAiringToday();
    } on Failure {
      rethrow;
    } on Exception catch (exception, stacktrace) {
      throw UnknownError(error: exception, stackTrace: stacktrace);
      // ignore: avoid_catches_without_on_clauses
    } catch (e, st) {
      throw UnknownError(error: e, stackTrace: st);
    }
  }

  @override
  Future<List<TvPopularShow>> getTvPopularShow() {
    try {
      return datasource.getTvPopularShow();
    } on Failure {
      rethrow;
    } on Exception catch (exception, stacktrace) {
      throw UnknownError(error: exception, stackTrace: stacktrace);
      // ignore: avoid_catches_without_on_clauses
    } catch (e, st) {
      throw UnknownError(error: e, stackTrace: st);
    }
  }

  @override
  Future<List<OnTheAir>> getOnTheAir() {
    try {
      return datasource.getTvOnTheAir();
    } on Failure {
      rethrow;
    } on Exception catch (exception, stacktrace) {
      throw UnknownError(error: exception, stackTrace: stacktrace);
      // ignore: avoid_catches_without_on_clauses
    } catch (e, st) {
      throw UnknownError(error: e, stackTrace: st);
    }
  }
}
