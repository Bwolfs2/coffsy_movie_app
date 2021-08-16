import '../entities/trailer.dart';
import '../repositories/discovery_movie_repository.dart';

class GetMovieTrailerById {
  final IDiscoveryMovieRepository repository;

  GetMovieTrailerById(this.repository);

  Future<List<Trailer>> call(int id) async {
    return await repository.getMovieTrailerById(id);
  }
}
