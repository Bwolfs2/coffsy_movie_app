import '../entities/crew.dart';
import '../repositories/discovery_movie_repository.dart';

class GetMovieCrewById {
  final IDiscoveryMovieRepository repository;

  GetMovieCrewById(this.repository);

  Stream<List<Crew>> call(int id) {
    return repository.getMovieCrew(id);
  }
}
