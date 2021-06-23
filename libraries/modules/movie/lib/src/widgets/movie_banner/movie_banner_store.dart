import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_triple/flutter_triple.dart';

class MovieBannerStore extends StreamStore<Failure, Result> {
  final Repository repository;
  MovieBannerStore(this.repository) : super(const Result()) {
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
        setError(const MovieNowPlayingNoInternetConnection());
      } else if (e.type == DioErrorType.other) {
        setError(const MovieNowPlayingNoInternetConnection());
      } else {
        setError(MovieNowPlayingError(
          e.toString(),
        ));
      }
    }

    setLoading(false);
  }
}

class MovieNowPlayingNoInternetConnection extends Failure {
  const MovieNowPlayingNoInternetConnection() : super(errorMessage: 'No Internet Connection');
}

class MovieNowPlayingError extends Failure {
  const MovieNowPlayingError(String errorMessage) : super(errorMessage: errorMessage);
}
