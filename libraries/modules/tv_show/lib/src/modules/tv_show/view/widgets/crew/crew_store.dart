import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/crew.dart';
import '../../../domain/usecases/get_movie_crew_by_id.dart';
import '../../../domain/usecases/get_tv_show_crew_by_id.dart';

class CrewStore extends StreamStore<Failure, List<Crew>> {
  final GetMovieCrewById _getMovieCrew;
  final GetTvShowCrewById _getTvShowCrew;

  CrewStore(this._getMovieCrew, this._getTvShowCrew) : super([]);

  Future<void> loadMovieTrailer(int movieId) => execute(() => _getMovieCrew(movieId));
  Future<void> loadTvShowTrailer(int tvShowId) => execute(() => _getTvShowCrew(tvShowId));
}
