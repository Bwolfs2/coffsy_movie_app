import 'package:flutter/cupertino.dart';

import '../crashalytics/crashalytics_services.dart';

abstract class Failure implements Exception {
  final String errorMessage;

  Failure({
    StackTrace? stackTrace,
    String? label,
    dynamic exception,
    this.errorMessage = '',
  }) {
    if (stackTrace != null) {
      debugPrintStack(label: label, stackTrace: stackTrace);
    }
    ErrorReport.externalFailureError(exception, stackTrace, label);
  }
}

class UnknownError extends Failure {
  final dynamic exception;
  final StackTrace? stackTrace;
  final String? label;

  UnknownError({
    this.label,
    this.exception,
    this.stackTrace,
    super.errorMessage = 'Unknown Error',
  }) : super(
          stackTrace: stackTrace,
          label: label,
          exception: exception,
        );
}
