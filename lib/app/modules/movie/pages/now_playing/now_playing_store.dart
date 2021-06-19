import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'errors/movie_now_playing_failures.dart';

class MoviePlayingStore extends StreamStore<Failure, Result> {
  final Repository repository;
  MoviePlayingStore(this.repository) : super(Result()) {
    load();
  }

  Future<void> load() async {
    try {
      setLoading(true);
      var movies = await repository.getMovieNowPlaying(ApiConstant.apiKey, ApiConstant.language);
      if (movies == null || movies.results.isEmpty) {
        update(EmptyResult(), force: true);
      } else {
        update(movies, force: true);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
        setError(MovieNowPlayingNoInternetConnection());
      } else if (e.type == DioErrorType.other) {
        setError(MovieNowPlayingNoInternetConnection());
      } else {
        setError(MovieNowPlayingError(e.toString()));
      }
    }

    setLoading(false);
  }
}
