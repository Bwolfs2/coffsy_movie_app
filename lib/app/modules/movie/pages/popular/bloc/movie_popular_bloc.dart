import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coffsy_design_system/coffsy_design_system.dart';

import 'movie_popular_event.dart';
import 'movie_popular_state.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  final Repository repository;

  MoviePopularBloc({required this.repository}) : super(InitialMoviePopular());

  @override
  Stream<MoviePopularState> mapEventToState(MoviePopularEvent event) async* {
    if (event is LoadMoviePopular) {
      yield* _mapLoadPopularToState();
    }
  }

  Stream<MoviePopularState> _mapLoadPopularToState() async* {
    try {
      yield MoviePopularLoading();
      var movies = await repository.getMoviePopular(ApiConstant.apiKey, ApiConstant.language);
      if (movies == null || movies.results.isEmpty) {
        yield MoviePopularNoData(AppConstant.noData);
      } else {
        yield MoviePopularHasData(movies);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
        yield MoviePopularNoInternetConnection();
      } else if (e.type == DioErrorType.other) {
        yield MoviePopularNoInternetConnection();
      } else {
        yield MoviePopularError(e.toString());
      }
    }
  }
}
