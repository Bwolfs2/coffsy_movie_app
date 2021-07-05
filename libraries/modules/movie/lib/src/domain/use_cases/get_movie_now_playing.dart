import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/movie.dart';
import '../repositories/movies_repository.dart';

abstract class IGetMovieNowPlaying {
  Future<Either<Failure, List<Movie>>> call();
}

class GetMovieNowPlaying implements IGetMovieNowPlaying {
  final MoviesRepository repository;

  GetMovieNowPlaying(this.repository);

  Future<Either<Failure, List<Movie>>> call() async {
    return await repository.getMovieNowPlaying();
  }
}
