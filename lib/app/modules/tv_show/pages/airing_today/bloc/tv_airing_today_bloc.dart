import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coffsy_design_system/coffsy_design_system.dart';

import 'tv_airing_today_event.dart';
import 'tv_airing_today_state.dart';

class TvAiringTodayBloc extends Bloc<TvAiringTodayEvent, TvAiringTodayState> {
  final Repository repository;

  TvAiringTodayBloc({required this.repository}) : super(InitialTvAiringToday());

  @override
  Stream<TvAiringTodayState> mapEventToState(TvAiringTodayEvent event) async* {
    if (event is LoadTvAiringToday) {
      yield* _mapLoadTvAiringTodayToState();
    }
  }

  Stream<TvAiringTodayState> _mapLoadTvAiringTodayToState() async* {
    try {
      yield TvAiringTodayLoading();
      var movies = await repository.getTvAiringToday(ApiConstant.apiKey, ApiConstant.language);
      if (movies == null || movies.results.isEmpty) {
        yield TvAiringTodayNoData(AppConstant.noData);
      } else {
        yield TvAiringTodayHasData(movies);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
        yield TvAiringTodayNoInternetConnection();
      } else if (e.type == DioErrorType.other) {
        yield TvAiringTodayNoInternetConnection();
      } else {
        yield TvAiringTodayError(e.toString());
      }
    }
  }
}
