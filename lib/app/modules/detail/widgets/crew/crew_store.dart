import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'errors/crew_failures.dart';

class CrewStore extends StreamStore<Failure, ResultCrew> {
  final Repository repository;
  CrewStore(this.repository) : super(ResultCrew());

  Future<void> loadMovieTrailer(int movieId) async {
    try {
      setLoading(true);
      var movies = await repository.getMovieCrew(movieId, ApiConstant.apiKey, ApiConstant.language);
      if (movies.crew.isEmpty) {
        update(EmptyResultCrew(), force: true);
      } else {
        update(movies, force: true);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
        setError(CrewNoInternetConnection());
      } else if (e.type == DioErrorType.other) {
        setError(CrewNoInternetConnection());
      } else {
        setError(CrewError(e.toString()));
      }
    }

    setLoading(false);
  }

  Future<void> loadTvShowTrailer(int movieId) async {
    try {
      setLoading(true);
      var movies = await repository.getTvShowCrew(movieId, ApiConstant.apiKey, ApiConstant.language);
      if (movies.crew.isEmpty) {
        update(EmptyResultCrew(), force: true);
      } else {
        update(movies, force: true);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
        setError(CrewNoInternetConnection());
      } else if (e.type == DioErrorType.other) {
        setError(CrewNoInternetConnection());
      } else {
        setError(CrewError(e.toString()));
      }
    }

    setLoading(false);
  }
}
