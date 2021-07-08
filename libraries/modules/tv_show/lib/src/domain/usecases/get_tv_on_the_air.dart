import '../entities/on_the_air.dart';
import '../repositories/tv_show_repository.dart';

class GetOnTheAir {
  final ITvShowRepository repository;

  GetOnTheAir(this.repository);

  Future<List<OnTheAir>> call() async {
    return await repository.getOnTheAir();
  }
}
