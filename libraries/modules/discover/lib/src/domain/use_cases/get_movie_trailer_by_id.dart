import '../entities/trailer.dart';
import '../repositories/discovery_movie_repository.dart';

class GetMovieTrailerById {
  final IDiscoveryMovieRepository repository;

  GetMovieTrailerById(this.repository);

  Stream<List<Trailer>> call(int id) {
    return repository.getMovieTrailerById(id);
  }
}
