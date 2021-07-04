import 'package:core/core.dart' hide Crew, Trailer;

import '../../domain/entities/crew.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/on_the_air.dart';
import '../../domain/entities/trailer.dart';
import '../../domain/entities/tv_popular_show.dart';
import '../../domain/errors/tv_show_failures.dart';
import '../../domain/repositories/tv_show_repository.dart';
import '../datasources/tv_show_datasource.dart';

class TvShowRepositoryImpl implements ITvShowRepository {
  final ITvShowDatasource datasource;

  TvShowRepositoryImpl(this.datasource);
  @override
  Future<List<Movie>> getTvAiringToday() async {
    try {
      var result = await datasource.getTvAiringToday();

      if (result.isEmpty) {
        throw NoDataFound();
      }

      return result;
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
  Future<List<TvPopularShow>> getTvPopularShow() async {
    try {
      var result = await datasource.getTvPopularShow();

      if (result.isEmpty) {
        throw NoDataFound();
      }

      return result;
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
  Future<List<OnTheAir>> getOnTheAir() async {
    try {
      var result = await datasource.getTvOnTheAir();

      if (result.isEmpty) {
        throw NoDataFound();
      }

      return result;
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
  Future<List<Crew>> getTvShowCrewById(int tvShowId) async {
    try {
      var result = await datasource.getTvShowCrewById(tvShowId);
      if (result.isEmpty) {
        throw NoDataFound();
      }
      return result;
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
  Future<List<Trailer>> getTvShowTrailerById(int tvShowId) async {
    try {
      var result = await datasource.getTvShowTrailerById(tvShowId);
      if (result.isEmpty) {
        throw NoDataFound();
      }
      return result;
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
