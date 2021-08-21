import '../entities/trailer.dart';
import '../repositories/discovery_movie_repository.dart';

class GetTvShowTrailerById {
  final IDiscoveryMovieRepository repository;

  GetTvShowTrailerById(this.repository);

  Stream<List<Trailer>> call(int movieId) {
    return repository.getTvShowTrailerById(movieId);
  }
}
