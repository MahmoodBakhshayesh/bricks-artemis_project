import '../models/networking/network_request.dart';
import '../models/networking/network_response.dart';

typedef NetworkHook = void Function(NetworkRequest req, NetworkResponse res);
typedef NetworkCheck = bool Function(NetworkRequest req, NetworkResponse res);
typedef NetworkMessageExtractor = String? Function(Map<String, dynamic> json);
