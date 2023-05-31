class Response {
  final int status;
  final String message;
  final dynamic body;

  factory Response.fromJson(json) => Response(body: json["Body"], status: json["Status"], message: json["Message"]);

  Response({required this.status, required this.message, required this.body});

  bool get isSuccess => status>0;
}
