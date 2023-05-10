import '../../../core.dart';

class HttpClientError extends Failure {
  HttpClientError(String? message, {StackTrace? stackTrace})
      : super(
          errorMessage: message ?? 'No Message found',
          stackTrace: stackTrace,
        );
}

class TimeOutError extends Failure {
  TimeOutError(String? message, {StackTrace? stackTrace})
      : super(
          errorMessage: message ?? 'No Message found',
          stackTrace: stackTrace,
        );
}
