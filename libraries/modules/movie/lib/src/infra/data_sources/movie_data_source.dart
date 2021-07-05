import '../../domain/entities/movie.dart';

abstract class MovieDataSource {
  Future<List<Movie>> getMovieNowPlaying();
  Future<List<Movie>> getMoviePopular();
  Future<List<Movie>> getMovieUpComming();
}
