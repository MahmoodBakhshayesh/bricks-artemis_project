import '../interface_implementations/response_imp.dart';
import 'request_int.dart';
import 'response_int.dart';

abstract class NetworkManagerInterface {

  Future<ResponseImplementation> post(RequestInterface request);
  Future<ResponseImplementation> get(String url);
}

