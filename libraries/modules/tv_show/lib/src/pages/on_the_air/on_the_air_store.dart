import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../errors/airing_today_failures.dart';

class OnTheAirStore extends StreamStore<Failure, Result> {
  final Repository repository;
  OnTheAirStore(this.repository)
      : super(
          Result(),
        ) {
    load();
  }

  Future<void> load() async {
    try {
      setLoading(true);
      var movies = await repository.getTvOnTheAir(ApiConstant.apiKey, ApiConstant.language);
      if (movies == null || movies.results.isEmpty) {
        update(EmptyResult(), force: true);
      } else {
        update(movies, force: true);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
        setError(
          OnTheAirNoInternetConnection(),
        );
      } else if (e.type == DioErrorType.other) {
        setError(
          OnTheAirNoInternetConnection(),
        );
      } else {
        setError(TvAiringTodayError(
          e.toString(),
        ));
      }
    }

    setLoading(false);
  }
}
