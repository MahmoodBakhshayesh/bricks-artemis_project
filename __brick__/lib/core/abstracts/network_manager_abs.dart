import 'request_abs.dart';
import 'response_abs.dart';

abstract class NetworkManagerInterface {

  Future<Response> post(Request request);
  Future<Response> get(String url);
}

