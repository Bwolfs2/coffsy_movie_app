import '../../domain/entities/crew.dart';
import '../../domain/entities/on_the_air.dart';
import '../../domain/entities/trailer.dart';
import '../../domain/entities/tv_popular_show.dart';
import '../../domain/entities/tv_show.dart';

abstract class ITvShowDatasource {
  Future<List<TvShow>> getTvAiringToday();
  Future<List<TvPopularShow>> getTvPopularShow();
  Future<List<OnTheAir>> getTvOnTheAir();
  Future<List<Crew>> getTvShowCrewById(int tvShowId);
  Future<List<Trailer>> getTvShowTrailerById(int tvShowId);
  Future<List<Crew>> getMovieCrew(int tvShowId);
  Future<List<Trailer>> getMovieTrailerById(int movieId);
}
