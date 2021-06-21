import 'package:core/core.dart';

class TvAiringTodayNoInternetConnection extends Failure {
  const TvAiringTodayNoInternetConnection() : super(errorMessage: 'No Internet Connection');
}

class TvAiringTodayError extends Failure {
  const TvAiringTodayError(String errorMessage) : super(errorMessage: errorMessage);
}

class TvShowPopularNoInternetConnection extends Failure {
  const TvShowPopularNoInternetConnection();
}

class TvShowBannerNoInternetConnection extends Failure {
  const TvShowBannerNoInternetConnection();
}

class OnTheAirNoInternetConnection extends Failure {
  const OnTheAirNoInternetConnection();
}
