import '../entities/movie.dart';
import '../repositories/discovery_movie_repository.dart';

// ignore: one_member_abstracts
abstract class IGetDiscoverMovie {
  Future<List<Movie>> call();
}

class GetDiscoverMovie implements IGetDiscoverMovie {
  final IDiscoveryMovieRepository _repository;

  GetDiscoverMovie(this._repository);

  Future<List<Movie>> call() async {
    return await _repository.getDiscoverMovie();
  }
}
