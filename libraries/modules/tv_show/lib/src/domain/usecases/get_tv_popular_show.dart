import '../entities/tv_popular_show.dart';
import '../repositories/tv_show_repository.dart';

class GetTvPopularShow {
  final ITvShowRepository repository;

  GetTvPopularShow(this.repository);

  Future<List<TvPopularShow>> call() async {
    return await repository.getTvPopularShow();
  }
}
