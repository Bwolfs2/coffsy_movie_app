import 'package:core/core.dart';

class NoDataFound extends Failure {}

abstract class NoInternetConnection extends Failure {
  NoInternetConnection() : super(errorMessage: 'No Internet Connection');
}

class MovieNowPlayingNoInternetConnection extends NoInternetConnection {}

class MovieNowPlayingError extends Failure {
  MovieNowPlayingError(
    StackTrace stackTrace,
    String label,
    dynamic exception,
    String errorMessage,
  ) : super(
          stackTrace: stackTrace,
          label: label,
          exception: exception,
          errorMessage: errorMessage,
        );
}

class MoviePopularNoInternetConnection extends NoInternetConnection {}

class MoviePopularError extends Failure {
  MoviePopularError(
    StackTrace stackTrace,
    String label,
    dynamic exception,
    String errorMessage,
  ) : super(
          stackTrace: stackTrace,
          label: label,
          exception: exception,
          errorMessage: errorMessage,
        );
}

class TrailerNoInternetConnection extends NoInternetConnection {}

class MovieUpComingNoInternetConnection extends NoInternetConnection {}

class MovieUpComingError extends Failure {
  MovieUpComingError(
    StackTrace stackTrace,
    String label,
    dynamic exception,
    String errorMessage,
  ) : super(
          stackTrace: stackTrace,
          label: label,
          exception: exception,
          errorMessage: errorMessage,
        );
}

class TrailerError extends Failure {
  TrailerError(
    StackTrace stackTrace,
    String label,
    dynamic exception,
    String errorMessage,
  ) : super(
          stackTrace: stackTrace,
          label: label,
          exception: exception,
          errorMessage: errorMessage,
        );
}

class CrewNoInternetConnection extends Failure {
  CrewNoInternetConnection() : super(errorMessage: 'No Internet Connection');
}

class CrewError extends Failure {
  CrewError(
    StackTrace stackTrace,
    String label,
    dynamic exception,
    String errorMessage,
  ) : super(
          stackTrace: stackTrace,
          label: label,
          exception: exception,
          errorMessage: errorMessage,
        );
}
