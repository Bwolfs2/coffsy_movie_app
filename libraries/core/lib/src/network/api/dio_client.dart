import 'package:dio/dio.dart';

import '../../firebase_performance/http_firebase_performance.dart';

class DioClient {
  final String apiBaseUrl;

  DioClient({required this.apiBaseUrl});

  Dio get dio => _getDio();

  Dio _getDio() {
    var options = BaseOptions(baseUrl: apiBaseUrl, connectTimeout: 50000, receiveTimeout: 30000);
    var dio = Dio(options);
    dio.interceptors.addAll([DioFirebasePerformanceInterceptor()]);
    return dio;
  }
}
