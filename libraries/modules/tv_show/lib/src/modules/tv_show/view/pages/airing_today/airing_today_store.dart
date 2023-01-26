import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/usecases/get_tv_airing_today.dart';
import 'airing_today_states.dart';

class AiringTodayStore extends ValueNotifier<AiringTodayState> {
  final GetTvAiringToday _getTvAiringToday;

  AiringTodayStore(this._getTvAiringToday) : super(AiringTodayLoading());

  void load() {
    _getTvAiringToday() //
        .then((data) {
      value = AiringTodayValued(data);
    }) //
        .onError<Failure>((error, _) {
      value = AiringTodayFailure(error);
    });
  }
}
