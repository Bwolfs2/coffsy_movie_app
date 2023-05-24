import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class CoffsyFirebaseAnalytics {
  CoffsyFirebaseAnalytics();

  Future<void> logEvent(String name, Map<String, dynamic> parameters) async {
    await FirebaseAnalytics.instance.logEvent(name: name, parameters: parameters);
  }

  Future<void> setUserId(String userId) async {
    await FirebaseAnalytics.instance.setUserId(id: userId);
  }

  Future<void> setCurrentScreen({required String screenName, String screenClassOverride = 'Flutter'}) async {
    await FirebaseAnalytics.instance.setCurrentScreen(screenName: screenName, screenClassOverride: screenClassOverride);
  }
}

VoidCallback logEventOnClick(
  String action,
  VoidCallback onTap, {
  Map<String, dynamic>? parameters,
}) =>
    () {
      FirebaseAnalytics.instance.logEvent(name: 'click_$action', parameters: parameters);
      return onTap();
    };
