import 'dart:async';

import 'package:core/core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CrashalytcsService.initializeFlutterFire();

  runZonedGuarded(() {
    runApp(ModularApp(module: AppModule(), child: AppWidget()));
  }, FirebaseCrashlytics.instance.recordError);
}
