import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../errors/discover_failures.dart';

class DiscoverStore extends StreamStore<Failure, Result> {
  final Repository repository;
  DiscoverStore(this.repository) : super(const Result());

  Future<void> load() async {
    try {
      setLoading(true);
      var movies = await repository.getDiscoverMovie(ApiConstant.apiKey, ApiConstant.language);
      if (movies == null || movies.results.isEmpty) {
        update(EmptyResult(), force: true);
      } else {
        update(movies, force: true);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
        setError(DiscoverMovieNoInternetConnection());
      } else if (e.type == DioErrorType.other) {
        setError(DiscoverMovieNoInternetConnection());
      } else {
        setError(DiscoverMovieError(e.toString()));
      }
    }

    setLoading(false);
  }
}
