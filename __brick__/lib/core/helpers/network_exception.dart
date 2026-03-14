class NetworkException implements Exception {
  final int? statusCode;
  final String message;
  final dynamic data; // server body if any
  final dynamic raw; // raw Dio Response or DioException
  final bool tokenExpired;
  final bool wasCancelled;

  NetworkException({
    required this.message,
    this.statusCode,
    this.data,
    this.raw,
    this.tokenExpired = false,
    this.wasCancelled = false,
  });

  @override
  String toString() => message;
}
