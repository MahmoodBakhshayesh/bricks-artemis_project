import 'http_method.dart';

class NetworkRequest {
  final HttpMethod method;
  final String pathOrUrl; // can be relative (uses baseUrl) or absolute (overrides)
  final Map<String, dynamic>? query;
  final Map<String, dynamic>? headers;
  final dynamic body;
  final bool? enableLogs;

  NetworkRequest(this.method, this.pathOrUrl, this.query, this.headers, this.body, this.enableLogs);

  @override
  String toString() => '${method.name} $pathOrUrl';
}
