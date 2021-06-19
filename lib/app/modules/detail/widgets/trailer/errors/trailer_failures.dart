import 'package:core/core.dart';

class TrailerNoInternetConnection extends Failure {
  const TrailerNoInternetConnection() : super(errorMessage: 'No Internet Connection');
}

class TrailerError extends Failure {
  const TrailerError(String errorMessage) : super(errorMessage: errorMessage);
}
