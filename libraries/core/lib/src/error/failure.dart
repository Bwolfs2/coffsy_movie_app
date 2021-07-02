abstract class Failure {
  final String errorMessage;

  const Failure({this.errorMessage = ''});
}

class UnknownError {
  final String errorMessage;
  final dynamic error;
  final StackTrace stackTrace;

  const UnknownError({this.errorMessage = 'Unknown Error', required this.error, required this.stackTrace});
}
