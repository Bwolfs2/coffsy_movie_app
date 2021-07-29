import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/tv_popular_show.dart';
import '../../../domain/usecases/get_tv_popular_show.dart';

class TvPopularStore extends StreamStore<Failure, List<TvPopularShow>> {
  final GetTvPopularShow _getTvPopularShow;
  TvPopularStore(this._getTvPopularShow) : super([]);

  Future<void> load() => execute(_getTvPopularShow);
}
