import '../entities/crew.dart';
import '../repositories/tv_show_repository.dart';

class GetMovieCrewById {
  final ITvShowRepository repository;

  GetMovieCrewById(this.repository);

  Future<List<Crew>> call(int id) async {
    return await repository.getMovieCrew(id);
  }
}
