import '../entities/trailer.dart';
import '../repositories/tv_show_repository.dart';

class GetTvShowTrailerById {
  final ITvShowRepository repository;

  GetTvShowTrailerById(this.repository);

  Future<List<Trailer>> call(int movieId) {
    return repository.getTvShowTrailerById(movieId);
  }
}
