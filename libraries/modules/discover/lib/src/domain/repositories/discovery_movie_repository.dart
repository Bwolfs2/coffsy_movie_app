import '../entities/crew.dart';
import '../entities/movie.dart';
import '../entities/trailer.dart';

abstract class IDiscoveryMovieRepository {
  Future<List<Movie>> getDiscoverMovie();
  Future<List<Trailer>> getTvShowTrailerById(int movieId);
  Future<List<Trailer>> getMovieTrailerById(int id);
  Future<List<Crew>> getTvShowCrewById(int movieId);
  Future<List<Crew>> getMovieCrew(int id);
}
