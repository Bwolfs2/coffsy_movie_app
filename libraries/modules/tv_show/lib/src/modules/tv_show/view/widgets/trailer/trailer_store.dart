import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/trailer.dart';
import '../../../domain/usecases/get_movie_trailer_by_id.dart';
import '../../../domain/usecases/get_tv_show_trailer_by_id.dart';

class TrailerStore extends StreamStore<Failure, List<Trailer>> {
  final GetTvShowTrailerById _getTvShowTrailerById;
  final GetMovieTrailerById _getMovieTrailerById;
  TrailerStore(this._getTvShowTrailerById, this._getMovieTrailerById) : super([]);

  Future<void> loadMovieTrailer(int movieId) => execute(() => _getMovieTrailerById(movieId));

  Future<void> loadTvShowTrailer(int movieId) => execute(() => _getTvShowTrailerById(movieId));
}
