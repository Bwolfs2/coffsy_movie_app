import 'package:core/core.dart';

class MovieNowPlayingNoInternetConnection extends Failure {
  const MovieNowPlayingNoInternetConnection() : super(errorMessage: 'No Internet Connection');
}

class MovieNowPlayingError extends Failure {
  const MovieNowPlayingError(String errorMessage) : super(errorMessage: errorMessage);
}
