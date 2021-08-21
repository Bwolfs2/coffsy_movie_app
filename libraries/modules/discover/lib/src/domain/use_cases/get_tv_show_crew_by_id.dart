import '../entities/crew.dart';
import '../repositories/discovery_movie_repository.dart';

class GetTvShowCrewById {
  final IDiscoveryMovieRepository repository;

  GetTvShowCrewById(this.repository);

  Stream<List<Crew>> call(int movieId) {
    return repository.getTvShowCrewById(movieId);
  }
}
