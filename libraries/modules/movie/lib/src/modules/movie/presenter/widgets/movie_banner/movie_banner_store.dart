import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/use_cases/get_movie_now_playing.dart';

class MovieBannerStore extends StreamStore<Failure, List<Movie>> {
  final IGetMovieNowPlaying _getMovieNowPlaying;

  MovieBannerStore(this._getMovieNowPlaying) : super([]);

  Future<void> load() async => executeEither(_getMovieNowPlaying);
}
