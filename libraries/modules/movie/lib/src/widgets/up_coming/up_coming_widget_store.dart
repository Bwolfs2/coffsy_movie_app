import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_triple/flutter_triple.dart';

class UpComingWidgetStore extends StreamStore<Failure, Result> {
  final Repository repository;
  UpComingWidgetStore(this.repository) : super(const Result()) {
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

class MovieUpComingNoInternetConnection extends Failure {
  const MovieUpComingNoInternetConnection() : super(errorMessage: 'No Internet Connection');
}

class MovieUpComingError extends Failure {
  const MovieUpComingError(String errorMessage) : super(errorMessage: errorMessage);
}
