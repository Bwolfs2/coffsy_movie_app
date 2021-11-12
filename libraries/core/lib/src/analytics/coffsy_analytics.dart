import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class CoffsyAnalytics {
  final FirebaseAnalytics _analytics = FirebaseAnalytics();

  CoffsyAnalytics();

  Future<void> logEvent(String name, Map<String, dynamic> parameters) async {
    await _analytics.logEvent(name: name, parameters: parameters);
  } 

  Future<void> setUserId(String userId) async {
    await _analytics.setUserId(userId);
  }

  Future<void> setCurrentScreen({required String screenName, String screenClassOverride = 'Flutter'}) async {
    await _analytics.setCurrentScreen(screenName: screenName, screenClassOverride: screenClassOverride);
  }

  Future<void> logAddToCart({
    required String itemId,
    required String itemName,
    required String itemCategory,
    required int quantity,
    double? price,
    double? value,
    String? currency,
    String? origin,
    String? itemLocationId,
    String? destination,
  }) async {
    await _analytics.logAddToCart(
      itemId: itemId,
      itemName: itemName,
      itemCategory: itemCategory,
      quantity: quantity,
      price: price,
      value: value,
      currency: currency,
      origin: origin,
      itemLocationId: itemLocationId,
      destination: destination,
    );
  }
}

final _analytics = FirebaseAnalytics();

VoidCallback logEventOnClick(
  String action,
  VoidCallback onTap, {
  Map<String, dynamic>? parameters,
}) =>
    () {
      _analytics.logEvent(name: 'click_$action', parameters: parameters);
      return onTap();
    };
