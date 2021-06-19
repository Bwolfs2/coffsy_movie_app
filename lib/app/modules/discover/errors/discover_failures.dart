import 'package:core/core.dart';

class DiscoverMovieNoInternetConnection extends Failure {
  const DiscoverMovieNoInternetConnection() : super(errorMessage: 'No Internet Connection');
}

class DiscoverMovieError extends Failure {
  const DiscoverMovieError(String errorMessage) : super(errorMessage: errorMessage);
}
