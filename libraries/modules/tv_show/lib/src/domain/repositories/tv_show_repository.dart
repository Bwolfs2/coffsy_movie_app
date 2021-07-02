import '../entities/movie.dart';
import '../entities/on_the_air.dart';
import '../entities/tv_popular_show.dart';

abstract class ITvShowRepository {
  Future<List<Movie>> getTvAiringToday();
  Future<List<TvPopularShow>> getTvPopularShow();
  Future<List<OnTheAir>> getOnTheAir();
}
