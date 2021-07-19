import '../entities/crew.dart';
import '../repositories/tv_show_repository.dart';

class GetTvShowCrewById {
  final ITvShowRepository repository;

  GetTvShowCrewById(this.repository);

  Future<List<Crew>> call(int movieId) async {
    return await repository.getTvShowCrewById(movieId);
  }
}
