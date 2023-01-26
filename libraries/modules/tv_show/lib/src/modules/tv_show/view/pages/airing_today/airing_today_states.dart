import 'package:core/core.dart';

import '../../../domain/entities/tv_show.dart';

abstract class AiringTodayState {}

class AiringTodayLoading extends AiringTodayState {}

class AiringTodayValued extends AiringTodayState {
  final List<TvShow> value;

  AiringTodayValued(this.value);
}

class AiringTodayFailure extends AiringTodayState {
  final Failure failure;

  AiringTodayFailure(this.failure);
}
