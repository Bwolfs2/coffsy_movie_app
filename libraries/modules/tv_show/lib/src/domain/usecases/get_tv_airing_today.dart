import '../entities/tv_show.dart';
import '../repositories/tv_show_repository.dart';

class GetTvAiringToday {
  final ITvShowRepository repository;

  GetTvAiringToday(this.repository);

  Future<List<TvShow>> call() async {
    return await repository.getTvAiringToday();
  }
}
