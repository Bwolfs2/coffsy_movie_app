import 'dart:developer';

import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:pulsar/pulsar.dart';

import 'modules/setting/pages/setting_store.dart';

// Firebase Analytics
CoffsyFirebaseAnalytics analytics = CoffsyFirebaseAnalytics();

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final store = SettingStore();
  @override
  void initState() {
    super.initState();
    Pulsar.to.addListener(() {
      try {
        final page = Pulsar.to.path.split('/').lastWhere((element) => element != '');
        analytics.setCurrentScreen(screenName: page);
        // ignore: avoid_catches_without_on_clauses
      } catch (e) {
        log(e.toString());
      }
    });
    setTripleResolver(tripleResolverCallback);
  }

  T tripleResolverCallback<T extends Object>() {
    return Pulsar.get<T>();
  }

  @override
  Widget build(BuildContext context) {
    Pulsar.setObservers([
      FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
    ]);

    return ScopedBuilder<SettingStore, Failure, bool>(
      store: store,
      onState: (context, state) {
        return MaterialApp.router(
          title: 'Coffsy Movie App',
          theme: Themes.lightTheme,
          darkTheme: Themes.darkTheme,
          themeMode: state ? ThemeMode.dark : ThemeMode.light,
          routerDelegate: Pulsar.routerDelegate,
          routeInformationParser: Pulsar.routeInformationParser,
        );
      },
    );
  }
}
