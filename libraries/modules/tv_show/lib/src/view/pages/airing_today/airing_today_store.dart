import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/tv_show.dart';
import '../../../domain/usecases/get_tv_airing_today.dart';

class AiringTodayStore extends StreamStore<Failure, List<TvShow>> {
  final GetTvAiringToday _getTvAiringToday;
  AiringTodayStore(this._getTvAiringToday) : super([]) {
    load();
  }

  Future<void> load() => execute(_getTvAiringToday);
}
