import '../entities/crew.dart';
import '../repositories/discovery_movie_repository.dart';

class GetMovieCrewById {
  final IDiscoveryMovieRepository repository;

  GetMovieCrewById(this.repository);

  Future<List<Crew>> call(int id) async {
    return await repository.getMovieCrew(id);
  }
}
