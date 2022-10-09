import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/crew.dart';
import '../repositories/movies_repository.dart';

abstract class IGetMovieCrewById {
  Future<Either<Failure, List<Crew>>> call(int id);
}

class GetMovieCrewById implements IGetMovieCrewById {
  final MoviesRepository repository;

  GetMovieCrewById(this.repository);

  @override
  Future<Either<Failure, List<Crew>>> call(int id) async {
    return repository.getMovieCrewById(id);
  }
}
