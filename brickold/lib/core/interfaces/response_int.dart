abstract class ResponseInterface {
  final int status;
  final String message;
  final dynamic body;

  ResponseInterface({required this.status, required this.message, required this.body});

  bool get isSuccess => status>0;
}
