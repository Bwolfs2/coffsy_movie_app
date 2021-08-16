import '../entities/crew.dart';
import '../repositories/discovery_movie_repository.dart';

class GetTvShowCrewById {
  final IDiscoveryMovieRepository repository;

  GetTvShowCrewById(this.repository);

  Future<List<Crew>> call(int movieId) async {
    return await repository.getTvShowCrewById(movieId);
  }
}
