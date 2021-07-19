import 'package:core/core.dart';

class TrailerNoInternetConnection extends Failure {
  TrailerNoInternetConnection() : super(errorMessage: 'No Internet Connection');
}

class TrailerError extends Failure {
  TrailerError(String errorMessage) : super(errorMessage: errorMessage);
}
