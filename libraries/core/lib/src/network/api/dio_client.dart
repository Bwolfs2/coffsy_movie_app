import 'package:dio/dio.dart';

import '../../../core.dart';
import '../../firebase_performance/http_firebase_performance.dart';

class DioClient {
  final ApiConfigurations configurations;

  DioClient({required this.configurations});

  Dio get dio => _getDio();

  Dio _getDio() {
    var options = BaseOptions(baseUrl: configurations.baseUrlProd, connectTimeout: 50000, receiveTimeout: 30000);
    var dio = Dio(options);
    dio.interceptors.addAll([DioFirebasePerformanceInterceptor(), AuthInterceptor(configurations)]);
    return dio;
  }
}

class AuthInterceptor extends Interceptor {
  final ApiConfigurations configurations;

  AuthInterceptor(this.configurations);

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.queryParameters = {
      'api_key': configurations.apiKey,
      'language': configurations.language,
    };

    return super.onRequest(options, handler);
  }
}
