import '../../domain/entities/crew.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/trailer.dart';

abstract class DiscoveryMovieDatasource {
  Future<List<Movie>> getDiscoverMovie();
  Future<List<Trailer>> getTvShowTrailerById(int movieId);
  Future<List<Trailer>> getMovieTrailerById(int id);
  Future<List<Crew>> getMovieCrew(int id);
  Future<List<Crew>> getTvShowCrewById(int movieId);
}
