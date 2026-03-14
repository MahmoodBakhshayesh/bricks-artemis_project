enum HttpMethod { get, post, put, patch, delete, upload, download }

extension HttpMethodName on HttpMethod {
  String get name => toString().split('.').last.toUpperCase();
}
