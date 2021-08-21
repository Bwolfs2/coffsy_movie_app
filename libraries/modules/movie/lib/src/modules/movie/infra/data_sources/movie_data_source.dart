import '../../domain/entities/crew.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/trailer.dart';

abstract class MovieDataSource {
  Future<List<Movie>> getMovieNowPlaying();
  Future<List<Movie>> getMoviePopular();
  Future<List<Movie>> getMovieUpComming();
  Future<List<Trailer>> getMovieTrailerById(int id);
  Future<List<Trailer>> getTvShowTrailerById(int id);

  Future<List<Crew>> getMovieCrewById(int id);

  Future<List<Crew>> getTvShowCrewById(int id);
}
