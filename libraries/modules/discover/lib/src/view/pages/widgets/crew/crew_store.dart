import 'package:core/core.dart' hide Crew;
import 'package:flutter_triple/flutter_triple.dart';

import '../../../../domain/entities/crew.dart';
import '../../../../domain/use_cases/get_movie_crew_by_id.dart';
import '../../../../domain/use_cases/get_tv_show_crew_by_id.dart';

class CrewStore extends StreamStore<Failure, List<Crew>> {
  final Repository repository;
  final GetMovieCrewById _getMovieCrew;
  final GetTvShowCrewById _getTvShowCrew;

  CrewStore(this.repository, this._getMovieCrew, this._getTvShowCrew) : super([]);

  Future<void> loadMovieTrailer(int movieId) async => execute(() => _getMovieCrew(movieId));
  Future<void> loadTvShowTrailer(int tvShowId) async => execute(() => _getTvShowCrew(tvShowId));
}
