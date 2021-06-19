import 'package:core/core.dart';

class MovieUpComingNoInternetConnection extends Failure {
  const MovieUpComingNoInternetConnection() : super(errorMessage: 'No Internet Connection');
}

class MovieUpComingError extends Failure {
  const MovieUpComingError(String errorMessage) : super(errorMessage: errorMessage);
}
