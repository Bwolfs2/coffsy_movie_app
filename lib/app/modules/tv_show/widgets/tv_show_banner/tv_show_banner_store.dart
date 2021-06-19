import 'package:coffsy_movie_app/app/modules/tv_show/errors/airing_today_failures.dart';
import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_triple/flutter_triple.dart';

class TvShowBannerStore extends StreamStore<Failure, Result> {
  final Repository repository;
  TvShowBannerStore(this.repository) : super(Result()) {
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
        setError(TvShowBannerNoInternetConnection());
      } else if (e.type == DioErrorType.other) {
        setError(TvShowBannerNoInternetConnection());
      } else {
        setError(TvAiringTodayError(e.toString()));
      }
    }

    setLoading(false);
  }
}
