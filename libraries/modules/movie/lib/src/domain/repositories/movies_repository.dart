import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/movie.dart';

abstract class MoviesRepository {
  Future<Either<Failure, List<Movie>>> getMovieNowPlaying();

  Future<Either<Failure, List<Movie>>> getMoviePopular();

  Future<Either<Failure, List<Movie>>> getMovieUpComming();
}
