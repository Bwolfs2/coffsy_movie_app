import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../errors/airing_today_failures.dart';

class AiringTodayStore extends StreamStore<Failure, Result> {
  final Repository repository;
  AiringTodayStore(this.repository)
      : super(
          Result(),
        ) {
    load();
  }

  Future<void> load() async {
    try {
      setLoading(true);
      var movies = await repository.getTvAiringToday(ApiConstant.apiKey, ApiConstant.language);
      if (movies == null || movies.results.isEmpty) {
        update(EmptyResult(), force: true);
      } else {
        update(movies, force: true);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
        setError(
          TvAiringTodayNoInternetConnection(),
        );
      } else if (e.type == DioErrorType.other) {
        setError(
          TvAiringTodayNoInternetConnection(),
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
