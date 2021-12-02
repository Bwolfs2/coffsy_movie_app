import 'package:dartz/dartz.dart';
import 'package:flutter_triple/flutter_triple.dart';

class DartzEitherAdapter<L, R> implements EitherAdapter<L, R> {
  // receive an usecase in constructor
  final Either<L, R> usecase;
  DartzEitherAdapter(this.usecase);

  @override
  T fold<T>(T Function(L l) leftF, T Function(R r) rightF) {
    return usecase.fold(leftF, rightF);
  }

  // Adapter Future Either(Dartz) to Future EitherAdapter(Triple)
  static Future<EitherAdapter<L, R>> adapter<L, R>(Future<Either<L, R>> usecase) {
    return usecase.then((value) => DartzEitherAdapter(value));
  }
}
