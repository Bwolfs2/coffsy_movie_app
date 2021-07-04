import 'package:core/core.dart' hide Trailer;
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/trailer.dart';
import '../../../domain/usecases/get_tv_show_trailer_by_id.dart';

class TrailerStore extends StreamStore<Failure, List<Trailer>> {
  final GetTvShowTrailerById _getTvShowTrailerById;
  TrailerStore(this._getTvShowTrailerById) : super([]);

  Future<void> loadTvShowTrailer(int tvShowId) => execute(() => _getTvShowTrailerById(tvShowId));
}
