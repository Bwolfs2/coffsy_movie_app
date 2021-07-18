import 'package:core/core.dart';

class DiscoverMovieNoInternetConnection extends Failure {
  DiscoverMovieNoInternetConnection() : super(errorMessage: 'No Internet Connection');
}

class DiscoverMovieError extends Failure {
  DiscoverMovieError(String errorMessage) : super(errorMessage: errorMessage);
}
