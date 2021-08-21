import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/crew.dart';
import '../entities/movie.dart';
import '../entities/trailer.dart';

abstract class MoviesRepository {
  Future<Either<Failure, List<Movie>>> getMovieNowPlaying();
  Future<Either<Failure, List<Movie>>> getMoviePopular();
  Future<Either<Failure, List<Movie>>> getMovieUpComming();
  Future<Either<Failure, List<Trailer>>> getMovieTrailerById(int id);
  Future<Either<Failure, List<Trailer>>> getTvShowTrailerById(int id);
  Future<Either<Failure, List<Crew>>> getMovieCrewById(int id);
  Future<Either<Failure, List<Crew>>> getTvShowCrewById(int id);
}
