import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/use_cases/get_discover_movie.dart';

class DiscoverStore extends StreamStore<Failure, List<Movie>> {
  final GetDiscoverMovie _getDiscoverMovie;
  DiscoverStore(this._getDiscoverMovie) : super([]);

  void load() => executeStream(_getDiscoverMovie());
}
