import 'package:core/core.dart';

abstract class NoInternetConnection extends Failure {
  const NoInternetConnection() : super(errorMessage: 'No Internet Connection');
}

class TvAiringTodayNoInternetConnection extends NoInternetConnection {}

class TvAiringTodayError extends Failure {
  const TvAiringTodayError(String errorMessage) : super(errorMessage: errorMessage);
}

class TvOnTheAirError extends Failure {
  const TvOnTheAirError(String errorMessage) : super(errorMessage: errorMessage);
}

class TvShowPopularError extends Failure {
  const TvShowPopularError(String errorMessage) : super(errorMessage: errorMessage);
}

class CrewError extends Failure {
  const CrewError(String errorMessage) : super(errorMessage: errorMessage);
}

class TrailerError extends Failure {
  const TrailerError(String errorMessage) : super(errorMessage: errorMessage);
}

class TvShowPopularNoInternetConnection extends NoInternetConnection {}

class TvShowBannerNoInternetConnection extends NoInternetConnection {}

class TvOnTheAirNoInternetConnection extends NoInternetConnection {}

class CrewNoInternetConnection extends NoInternetConnection {}

class TrailerNoInternetConnection extends NoInternetConnection {}

class NoDataFound extends Failure {}
