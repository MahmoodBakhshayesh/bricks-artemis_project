
import '../interfaces/response_int.dart';

class ResponseImplementation extends ResponseInterface {
  ResponseImplementation({required super.message, required super.body, required super.status});



  factory ResponseImplementation.fromJson(Map<String, dynamic> json) => ResponseImplementation(
        status: json['Status'],
        message: json['Message'],
        body: json['Body'],
      );
}
