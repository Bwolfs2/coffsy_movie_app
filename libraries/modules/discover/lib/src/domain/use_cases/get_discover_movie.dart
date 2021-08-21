import '../entities/movie.dart';
import '../repositories/discovery_movie_repository.dart';

class GetDiscoverMovie {
  final IDiscoveryMovieRepository _repository;

  GetDiscoverMovie(this._repository);

  Stream<List<Movie>> call() {
    return _repository.getDiscoverMovie();
  }
}
