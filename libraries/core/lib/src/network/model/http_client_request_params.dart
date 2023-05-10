import 'http_request_methods_enum.dart';

class HttpClientRequestParams {
  final String endPoint;
  final HttpRequestMethodsEnum method;
  final dynamic body;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? queryParams;
  final void Function(int count, int total)? onReceiveProgress;
  final void Function(int count, int total)? onSendProgress;

  const HttpClientRequestParams({
    required this.endPoint,
    required this.method,
    this.body,
    this.headers,
    this.queryParams,
    this.onReceiveProgress,
    this.onSendProgress,
  });
}
