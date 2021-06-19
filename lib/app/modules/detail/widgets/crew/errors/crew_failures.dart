import 'package:core/core.dart';

class CrewNoInternetConnection extends Failure {
  const CrewNoInternetConnection() : super(errorMessage: 'No Internet Connection');
}

class CrewError extends Failure {
  const CrewError(String errorMessage) : super(errorMessage: errorMessage);
}
