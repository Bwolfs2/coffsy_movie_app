import '../../domain/entities/movie.dart';
import '../../domain/entities/on_the_air.dart';
import '../../domain/entities/tv_popular_show.dart';

abstract class ITvShowDatasource {
  Future<List<Movie>> getTvAiringToday();
  Future<List<TvPopularShow>> getTvPopularShow();
  Future<List<OnTheAir>> getTvOnTheAir();
}
