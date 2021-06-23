import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'errors/movie_up_coming_failures.dart';

class UpComingStore extends StreamStore<Failure, Result> {
  final Repository repository;
  UpComingStore(this.repository) : super(const Result()) {
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
        setError(const MovieUpComingNoInternetConnection());
      } else if (e.type == DioErrorType.other) {
        setError(const MovieUpComingNoInternetConnection());
      } else {
        setError(MovieUpComingError(
          e.toString(),
        ));
      }
    }

    setLoading(false);
  }
}
