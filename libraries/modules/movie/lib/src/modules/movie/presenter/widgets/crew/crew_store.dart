import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/crew.dart';
import '../../../domain/use_cases/get_movie_crew_by_id.dart';
import '../../../domain/use_cases/get_tv_show_crew_by_id.dart';

class CrewStore extends StreamStore<Failure, List<Crew>> {
  final IGetMovieCrewById _getMovieCrewById;
  final IGetTvShowCrewById _getTvShowCrewById;

  CrewStore(this._getMovieCrewById, this._getTvShowCrewById) : super([]);

  Future<void> loadMovieTrailer(int movieId) async => executeEither(() =>  DartzEitherAdapter.adapter(_getMovieCrewById(movieId)));
  Future<void> loadTvShowTrailer(int movieId) async => executeEither(() => DartzEitherAdapter.adapter(_getTvShowCrewById(movieId)));
}
