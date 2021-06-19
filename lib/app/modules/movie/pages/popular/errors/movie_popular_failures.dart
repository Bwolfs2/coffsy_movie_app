import 'package:core/core.dart';

class MoviePopularNoInternetConnection extends Failure {
  const MoviePopularNoInternetConnection() : super(errorMessage: 'No Internet Connection');
}

class MoviePopularError extends Failure {
  const MoviePopularError(String errorMessage) : super(errorMessage: errorMessage);
}
