import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'errors/trailer_failures.dart';

class TrailerStore extends StreamStore<Failure, ResultTrailer> {
  final Repository repository;
  TrailerStore(this.repository) : super(const ResultTrailer());

  Future<void> loadMovieTrailer(int movieId) async {
    try {
      setLoading(true);
      var movies = await repository.getMovieTrailer(movieId, ApiConstant.apiKey, ApiConstant.language);
      if (movies.trailer.isEmpty) {
        update(EmptyResultTrailer(), force: true);
      } else {
        update(movies, force: true);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
        setError(TrailerNoInternetConnection());
      } else if (e.type == DioErrorType.other) {
        setError(TrailerNoInternetConnection());
      } else {
        setError(TrailerError(e.toString()));
      }
    }

    setLoading(false);
  }

  Future<void> loadTvShowTrailer(int movieId) async {
    try {
      setLoading(true);
      var movies = await repository.getTvShowTrailer(movieId, ApiConstant.apiKey, ApiConstant.language);
      if (movies.trailer.isEmpty) {
        update(EmptyResultTrailer(), force: true);
      } else {
        update(movies, force: true);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
        setError(TrailerNoInternetConnection());
      } else if (e.type == DioErrorType.other) {
        setError(TrailerNoInternetConnection());
      } else {
        setError(TrailerError(e.toString()));
      }
    }

    setLoading(false);
  }
}
