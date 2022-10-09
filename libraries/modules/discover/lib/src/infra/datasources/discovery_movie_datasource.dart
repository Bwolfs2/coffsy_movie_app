import '../../domain/entities/crew.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/trailer.dart';

abstract class DiscoveryMovieDatasource {
  Future<List<Movie>> getDiscoverMovie();
  Future<List<Trailer>> getTvShowTrailerById(int tvShowId);
  Future<List<Trailer>> getMovieTrailerById(int movieId);
  Future<List<Crew>> getMovieCrew(int movieId);
  Future<List<Crew>> getTvShowCrewById(int tvShowId);
}
