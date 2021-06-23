import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'errors/movie_popular_failures.dart';

class MoviePopularStore extends StreamStore<Failure, Result> {
  final Repository repository;
  MoviePopularStore(this.repository) : super(const Result()) {
    load();
  }

  Future<void> load() async {
    try {
      setLoading(true);
      var movies = await repository.getMoviePopular(ApiConstant.apiKey, ApiConstant.language);
      if (movies == null || movies.results.isEmpty) {
        update(EmptyResult(), force: true);
      } else {
        update(movies, force: true);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
        setError(
          const MoviePopularNoInternetConnection(),
        );
      } else if (e.type == DioErrorType.other) {
        setError(
          const MoviePopularNoInternetConnection(),
        );
      } else {
        setError(MoviePopularError(
          e.toString(),
        ));
      }
    }

    setLoading(false);
  }
}
