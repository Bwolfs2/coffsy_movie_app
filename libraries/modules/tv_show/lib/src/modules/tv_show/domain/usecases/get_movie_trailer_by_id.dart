import '../entities/trailer.dart';
import '../repositories/tv_show_repository.dart';

class GetMovieTrailerById {
  final ITvShowRepository repository;

  GetMovieTrailerById(this.repository);

  Future<List<Trailer>> call(int id) async {
    return await repository.getMovieTrailerById(id);
  }
}
