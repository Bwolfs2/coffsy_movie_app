import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/use_cases/get_movie_popular.dart';

class MoviePopularStore extends StreamStore<Failure, List<Movie>> {
  final IGetMoviePopular _getMoviePopular;
  MoviePopularStore(this._getMoviePopular) : super([]);

  Future<void> load() async => executeEither(() => DartzEitherAdapter.adapter(_getMoviePopular()));
}
