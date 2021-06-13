import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coffsy_design_system/coffsy_design_system.dart';

class MovieNowPlayingBloc extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  final Repository repository;

  MovieNowPlayingBloc({required this.repository}) : super(InitialMovieNowPlaying());

  @override
  Stream<MovieNowPlayingState> mapEventToState(MovieNowPlayingEvent event) async* {
    if (event is LoadMovieNowPlaying) {
      yield* _mapLoadNowPlayingToState();
    }
  }

  Stream<MovieNowPlayingState> _mapLoadNowPlayingToState() async* {
    try {
      yield MovieNowPlayingLoading();
      var movies = await repository.getMovieNowPlaying(ApiConstant.apiKey, ApiConstant.language);
      if (movies == null || movies.results.isEmpty) {
        yield MovieNowPlayingNoData(AppConstant.noData);
      } else {
        yield MovieNowPlayingHasData(movies);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
        yield MovieNowPlayingNoInternetConnection();
      } else if (e.type == DioErrorType.other) {
        yield MovieNowPlayingNoInternetConnection();
      } else {
        yield MovieNowPlayingError(e.toString());
      }
    }
  }
}
