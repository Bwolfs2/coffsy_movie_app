import 'dart:convert';

import 'package:coffsy_design_system/coffsy_design_system.dart';

import '../../../core.dart';

class LocalRepository implements Repository {
  final SharedPrefHelper prefHelper;

  LocalRepository({required this.prefHelper});

  @override
  Future<Result?> getMovieNowPlaying([String apiKey = ApiConstant.apiKey, String language = ApiConstant.language]) async {
    var fromCache = await prefHelper.getCache(AppConstant.movieNowPlaying);
    if (fromCache != null) {
      Map<String, dynamic> json = jsonDecode(fromCache);
      return Result.fromJson(json);
    }
    return null;
  }

  @override
  Future<Result?> getMovieUpComing([String apiKey = ApiConstant.apiKey, String language = ApiConstant.language]) async {
    var fromCache = await prefHelper.getCache(AppConstant.movieUpComing);
    if (fromCache != null) {
      Map<String, dynamic> json = jsonDecode(fromCache);
      return Result.fromJson(json);
    }
    return null;
  }

  @override
  Future<Result?> getMoviePopular([String apiKey = ApiConstant.apiKey, String language = ApiConstant.language]) async {
    var fromCache = await prefHelper.getCache(AppConstant.moviePopular);
    if (fromCache != null) {
      Map<String, dynamic> json = jsonDecode(fromCache);
      return Result.fromJson(json);
    }
    return null;
  }

  Future<bool> saveMovieNowPlaying(Result result) {
    return prefHelper.storeCache(AppConstant.movieNowPlaying, jsonEncode(result));
  }

  Future<bool> saveMovieUpComing(Result result) {
    return prefHelper.storeCache(AppConstant.movieUpComing, jsonEncode(result));
  }

  Future<bool> saveMoviePopular(Result result) {
    return prefHelper.storeCache(AppConstant.moviePopular, jsonEncode(result));
  }

  Future<bool> saveTvAiringToday(Result result) {
    return prefHelper.storeCache(AppConstant.tvAiringToday, jsonEncode(result));
  }

  Future<bool> saveTvPopular(Result result) {
    return prefHelper.storeCache(AppConstant.tvPopular, jsonEncode(result));
  }

  Future<bool> saveTvOnTheAir(Result result) {
    return prefHelper.storeCache(AppConstant.tvOnTheAir, jsonEncode(result));
  }

  @override
  Future<ResultCrew> getMovieCrew([int? movieId, String apiKey = ApiConstant.apiKey, String language = ApiConstant.language]) {
    throw UnimplementedError();
  }

  @override
  Future<ResultTrailer> getMovieTrailer(int movieId, [String apiKey = ApiConstant.apiKey, String language = ApiConstant.language]) {
    throw UnimplementedError();
  }

  @override
  Future<ResultCrew> getTvShowCrew([int? tvId, String apiKey = ApiConstant.apiKey, String language = ApiConstant.language]) {
    throw UnimplementedError();
  }

  @override
  Future<ResultTrailer> getTvShowTrailer(int tvId, [String apiKey = ApiConstant.apiKey, String language = ApiConstant.language]) {
    throw UnimplementedError();
  }

  @override
  Future<Result?> getDiscoverMovie([String apiKey = ApiConstant.apiKey, String language = ApiConstant.language]) async {
    var fromCache = await prefHelper.getCache(AppConstant.discoverMovie);
    if (fromCache != null) {
      Map<String, dynamic> json = jsonDecode(fromCache);
      return Result.fromJson(json);
    }
    return null;
  }

  Future<bool> saveDiscoverMovie(Result result) {
    return prefHelper.storeCache(AppConstant.discoverMovie, jsonEncode(result));
  }
}
