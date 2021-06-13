import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coffsy_design_system/coffsy_design_system.dart';

class MovieUpComingBloc extends Bloc<MovieUpComingEvent, MovieUpComingState> {
  final Repository repository;

  MovieUpComingBloc({required this.repository}) : super(InitialMovieUpComing());

  @override
  Stream<MovieUpComingState> mapEventToState(MovieUpComingEvent event) async* {
    if (event is LoadMovieUpComing) {
      yield* _mapLoadNowPlayingToState();
    }
  }

  Stream<MovieUpComingState> _mapLoadNowPlayingToState() async* {
    try {
      yield MovieUpComingLoading();
      var movies = await repository.getMovieUpComing(ApiConstant.apiKey, ApiConstant.language);
      if (movies == null || movies.results.isEmpty) {
        yield MovieUpComingNoData(AppConstant.noData);
      } else {
        yield MovieUpComingHasData(movies);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
        yield MovieUpComingNoInternetConnection();
      } else if (e.type == DioErrorType.other) {
        yield MovieUpComingNoInternetConnection();
      } else {
        yield MovieUpComingError(e.toString());
      }
    }
  }
}
