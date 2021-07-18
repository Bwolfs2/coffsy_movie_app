import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await _initializeFlutterFire();

  runZonedGuarded(() {
    runApp(ModularApp(module: AppModule(), child: AppWidget()));
  }, FirebaseCrashlytics.instance.recordError);
}

Future<void> _initializeFlutterFire() async {
  try {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true /*!kDebugMode*/);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    // ignore: avoid_catches_without_on_clauses
  } catch (error) {
    debugPrint(
      "Couldn't load FirebaseCrashlytics. $error",
    );
  }
}
