import 'package:core/core.dart';
import 'package:dio/dio.dart' hide ProgressCallback;

import '../../firebase_performance/http_firebase_performance.dart';
import '../params/http_client_request_params.dart';
import '../params/http_request_methods_enum.dart';

class DioHttpClient extends IHttpClient {
  final String baseApiUrl;
  final List<Interceptor> interceptors;
  late final Dio _dio;
  DioHttpClient({
    this.baseApiUrl = '',
    Map<String, dynamic> headers = const {},
    this.interceptors = const [],
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseApiUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );
    _dio.options.headers.addAll(headers);

    _dio.interceptors.addAll([
      ...interceptors,
      DioFirebasePerformanceInterceptor(),
    ]);
  }

  @override
  Future<HttpClientResponse> request(HttpClientRequestParams params) async {
    try {
      final response = await _dio.request(
        params.endPoint,
        data: params.body,
        queryParameters: params.queryParams,
        options: Options(method: params.method.name, headers: params.headers),
        onReceiveProgress: params.onReceiveProgress,
        onSendProgress: params.onSendProgress,
      );

      return HttpClientResponse(
        data: response.data,
        statusCode: response.statusCode!,
      );
    } on DioError catch (error) {
      if (error.type == DioErrorType.connectionError || error.type == DioErrorType.receiveTimeout) {
        throw TimeOutError(error.message, stackTrace: error.stackTrace);
      }
      throw HttpClientError(error.message, stackTrace: error.stackTrace);
    }
  }

  @override
  Future<HttpClientResponse> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return request(
      HttpClientRequestParams(
        endPoint: path,
        method: HttpRequestMethodsEnum.get,
        body: data,
        queryParams: queryParameters,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
      ),
    );
  }

  @override
  Future<HttpClientResponse> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return request(
      HttpClientRequestParams(
        endPoint: path,
        method: HttpRequestMethodsEnum.post,
        body: data,
        queryParams: queryParameters,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
      ),
    );
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
