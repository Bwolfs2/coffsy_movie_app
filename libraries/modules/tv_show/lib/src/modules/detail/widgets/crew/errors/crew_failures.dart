import 'package:core/core.dart';

class CrewNoInternetConnection extends Failure {
  CrewNoInternetConnection() : super(errorMessage: 'No Internet Connection');
}

class CrewError extends Failure {
  CrewError(String errorMessage) : super(errorMessage: errorMessage);
}
