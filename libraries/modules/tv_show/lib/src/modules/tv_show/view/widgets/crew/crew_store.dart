import 'package:core/core.dart' hide Crew;
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/crew.dart';
import '../../../domain/usecases/get_movie_crew_by_id.dart';
import '../../../domain/usecases/get_tv_show_crew_by_id.dart';

class CrewStore extends StreamStore<Failure, List<Crew>> {
  final Repository repository;
  final GetMovieCrewById _getMovieCrew;
  final GetTvShowCrewById _getTvShowCrew;

  CrewStore(this.repository, this._getMovieCrew, this._getTvShowCrew) : super([]);

  Future<void> loadMovieTrailer(int movieId) async => execute(() => _getMovieCrew(movieId));

  //  {
  //   try {
  //     setLoading(true);
  //     var movies = await repository.getMovieCrew(movieId, ApiConstant.apiKey, ApiConstant.language);
  //     if (movies.crew.isEmpty) {
  //       update(EmptyResultCrew(), force: true);
  //     } else {
  //       update(movies, force: true);
  //     }
  //   } on DioError catch (e) {
  //     if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
  //       setError(CrewNoInternetConnection());
  //     } else if (e.type == DioErrorType.other) {
  //       setError(CrewNoInternetConnection());
  //     } else {
  //       //     setError(CrewError( e.toString()));
  //     }
  //   }

  //   setLoading(false);
  // }

  Future<void> loadTvShowTrailer(int tvShowId) async => execute(() => _getTvShowCrew(tvShowId));
}
