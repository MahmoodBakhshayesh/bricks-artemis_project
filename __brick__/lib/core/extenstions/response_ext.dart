import '../interfaces/response_int.dart';
import '../interfaces/success_int.dart';

extension ResponseDetails on ResponseInterface {
  ServerSuccess get getSuccess => ServerSuccess(code: status, msg: message);
}