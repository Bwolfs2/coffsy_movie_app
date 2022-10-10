import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class CoffsyAnalytics {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  CoffsyAnalytics();

  Future<void> logEvent(String name, Map<String, dynamic> parameters) async {
    await _analytics.logEvent(name: name, parameters: parameters);
  }

  Future<void> setUserId(String userId) async {
    await _analytics.setUserId(id: userId);
  }

  Future<void> setCurrentScreen({required String screenName, String screenClassOverride = 'Flutter'}) async {
    await _analytics.setCurrentScreen(screenName: screenName, screenClassOverride: screenClassOverride);
  }
}

final _analytics = FirebaseAnalytics.instance;

VoidCallback logEventOnClick(
  String action,
  VoidCallback onTap, {
  Map<String, dynamic>? parameters,
}) =>
    () {
      _analytics.logEvent(name: 'click_$action', parameters: parameters);
      return onTap();
    };
