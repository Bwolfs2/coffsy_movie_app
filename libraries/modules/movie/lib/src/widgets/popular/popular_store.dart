import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_triple/flutter_triple.dart';

class PopularStore extends StreamStore<Failure, Result> {
  final Repository repository;
  PopularStore(this.repository)
      : super(
          Result(),
        ) {
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
          MoviePopularNoInternetConnection(),
        );
      } else if (e.type == DioErrorType.other) {
        setError(
          MoviePopularNoInternetConnection(),
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

class MoviePopularNoInternetConnection extends Failure {
  const MoviePopularNoInternetConnection() : super(errorMessage: 'No Internet Connection');
}

class MoviePopularError extends Failure {
  const MoviePopularError(String errorMessage) : super(errorMessage: errorMessage);
}
