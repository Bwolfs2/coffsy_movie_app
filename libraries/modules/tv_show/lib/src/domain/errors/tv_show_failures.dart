import 'package:core/core.dart';

abstract class NoInternetConnection extends Failure {
  NoInternetConnection() : super(errorMessage: 'No Internet Connection');
}

class TvAiringTodayNoInternetConnection extends NoInternetConnection {}

class TvAiringTodayError extends Failure {
  TvAiringTodayError(
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

class TvOnTheAirError extends Failure {
  TvOnTheAirError(
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

class TvShowPopularError extends Failure {
  TvShowPopularError(
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

class TvShowPopularNoInternetConnection extends NoInternetConnection {}

class TvShowBannerNoInternetConnection extends NoInternetConnection {}

class TvOnTheAirNoInternetConnection extends NoInternetConnection {}

class CrewNoInternetConnection extends NoInternetConnection {}

class TrailerNoInternetConnection extends NoInternetConnection {}

class NoDataFound extends Failure {}
