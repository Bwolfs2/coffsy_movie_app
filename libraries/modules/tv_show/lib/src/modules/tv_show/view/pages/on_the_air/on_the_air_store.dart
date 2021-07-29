import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/on_the_air.dart';
import '../../../domain/usecases/get_tv_on_the_air.dart';

class OnTheAirStore extends StreamStore<Failure, List<OnTheAir>> {
  final GetOnTheAir _getTvOnTheAir;
  OnTheAirStore(this._getTvOnTheAir) : super([]);

  Future<void> load() => execute(_getTvOnTheAir);
}
