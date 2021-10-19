import 'package:flutter_triple/flutter_triple.dart';
import 'package:core/core.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/use_cases/get_movie_now_playing.dart';

class MovieBannerStore extends StreamStore<Failure, List<Movie>> {
  final IGetMovieNowPlaying _getMovieNowPlaying;

  MovieBannerStore(this._getMovieNowPlaying) : super([]) {
    load();
  }

  Future<void> load() async => executeEither(() => DartzEitherAdapter.adapter(_getMovieNowPlaying()));
}
