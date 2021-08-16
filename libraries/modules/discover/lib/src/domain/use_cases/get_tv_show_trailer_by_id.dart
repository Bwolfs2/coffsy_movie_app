import '../entities/trailer.dart';
import '../repositories/discovery_movie_repository.dart';

class GetTvShowTrailerById {
  final IDiscoveryMovieRepository repository;

  GetTvShowTrailerById(this.repository);

  Future<List<Trailer>> call(int movieId) async {
    return await repository.getTvShowTrailerById(movieId);
  }
}
