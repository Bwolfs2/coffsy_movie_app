import 'dart:io';
import 'dart:isolate';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CrashalytcsService {
  static Future<void> initializeFlutterFire() async {
    try {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      Isolate.current.addErrorListener(ErrorReport.isolateErrorListener);
      // ignore: avoid_catches_without_on_clauses
    } catch (error) {
      debugPrint(
        'Couldn t load FirebaseCrashlytics. $error',
      );
    }
  }
}

class ErrorReport {
  static Future<void> _report(
    dynamic exception,
    StackTrace stackTrace,
    String tag,
  ) async {
    if (!(Platform.environment.containsKey('FLUTTER_TEST')) && exception != null) {
      debugPrintStack(label: tag, stackTrace: stackTrace);

      await FirebaseCrashlytics.instance.setCustomKey(tag, exception.toString());
      await FirebaseCrashlytics.instance.log(exception.toString());
      await FirebaseCrashlytics.instance.recordError(exception, stackTrace);
    }
  }

  static void externalFailureError(dynamic exception, StackTrace? stackTrace, String? reportTag) {
    if (stackTrace != null && reportTag != null) {
      _report(exception, stackTrace, 'EXTERNAL_FAILURE: $reportTag');
    }
  }

  static SendPort get isolateErrorListener {
    return RawReceivePort((pair) async {
      final List<dynamic> errorAndStacktrace = pair;
      final exception = errorAndStacktrace[0];
      final stackTrace = errorAndStacktrace[1];
      _report(exception, stackTrace, 'ISOLATE');
    }).sendPort;
  }
}
