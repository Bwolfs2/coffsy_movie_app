import '../entities/crew.dart';
import '../entities/on_the_air.dart';
import '../entities/trailer.dart';
import '../entities/tv_popular_show.dart';
import '../entities/tv_show.dart';

abstract class ITvShowRepository {
  Future<List<TvShow>> getTvAiringToday();
  Future<List<TvPopularShow>> getTvPopularShow();
  Future<List<OnTheAir>> getOnTheAir();
  Future<List<Crew>> getTvShowCrewById(int movieId);
  Future<List<Trailer>> getTvShowTrailerById(int movieId);
  Future<List<Crew>> getMovieCrew(int id);
  Future<List<Trailer>> getMovieTrailerById(int id);
}
