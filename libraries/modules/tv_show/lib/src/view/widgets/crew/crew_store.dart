import 'package:core/core.dart' hide Crew;
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/crew.dart';
import '../../../domain/usecases/get_tv_show_crew_by_id.dart';

class CrewStore extends StreamStore<Failure, List<Crew>> {
  final GetTvShowCrewById _getTvShowCrewById;

  CrewStore(this._getTvShowCrewById) : super([]);

  Future<void> loadTvShowTrailer(int movieId) => execute(() => _getTvShowCrewById(movieId));
}
