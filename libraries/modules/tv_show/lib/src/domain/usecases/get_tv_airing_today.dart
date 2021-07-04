import '../entities/movie.dart';
import '../repositories/tv_show_repository.dart';

class GetTvAiringToday {
  final ITvShowRepository repository;

  GetTvAiringToday(this.repository);

  Future<List<Movie>> call() async {
    return await repository.getTvAiringToday();
  }
}
