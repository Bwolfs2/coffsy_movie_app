import '../entities/crew.dart';
import '../entities/movie.dart';
import '../entities/trailer.dart';

abstract class IDiscoveryMovieRepository {
  Stream<List<Movie>> getDiscoverMovie();
  Stream<List<Trailer>> getTvShowTrailerById(int movieId);
  Stream<List<Trailer>> getMovieTrailerById(int id);
  Stream<List<Crew>> getTvShowCrewById(int movieId);
  Stream<List<Crew>> getMovieCrew(int id);
}
