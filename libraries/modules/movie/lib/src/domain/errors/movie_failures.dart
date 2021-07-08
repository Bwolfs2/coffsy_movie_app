import 'package:core/core.dart';

class NoDataFound extends Failure {}

abstract class NoInternetConnection extends Failure {
  const NoInternetConnection() : super(errorMessage: 'No Internet Connection');
}

class MovieNowPlayingNoInternetConnection extends NoInternetConnection {}

class MovieNowPlayingError extends Failure {
  const MovieNowPlayingError(String errorMessage) : super(errorMessage: errorMessage);
}

class MoviePopularNoInternetConnection extends NoInternetConnection {}

class MoviePopularError extends Failure {
  const MoviePopularError(String errorMessage) : super(errorMessage: errorMessage);
}

class MovieUpComingNoInternetConnection extends NoInternetConnection {}

class MovieUpComingError extends Failure {
  const MovieUpComingError(String errorMessage) : super(errorMessage: errorMessage);
}
