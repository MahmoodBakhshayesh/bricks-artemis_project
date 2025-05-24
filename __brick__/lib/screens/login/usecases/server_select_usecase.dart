import 'package:dartz/dartz.dart';
import '../../../core/interface_implementations/response_imp.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/classes/server_class.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../login_repository.dart';

class ServerSelectUseCase extends UseCase<ServerSelectResponse, ServerSelectRequest> {
  ServerSelectUseCase();

  @override
  Future<Result<ServerSelectResponse>> call({required ServerSelectRequest request}) {
    if (request.validate() != null) return Future(() => Result.error(request.validate()!));
    LoginRepository repository = LoginRepository();
    return repository.serverSelect(request);
  }
}

class ServerSelectRequest extends RequestInterface {
  ServerSelectRequest();

  @override
  Map<String, dynamic> toJson() => {
    "Body": {
      "Execution": "ServerList",
      "Token": token,
      "Request": {},
    },
  };

  Failure? validate() {
    return null;
  }
}

class ServerSelectResponse extends ResponseImplementation {
  final List<Server> servers;

  ServerSelectResponse({required int status, required String message, required this.servers}) : super(status: status, message: message, body: {"ServerList": servers.map((e) => e.toJson()).toList()});

  factory ServerSelectResponse.fromResponse(ResponseImplementation res) => ServerSelectResponse(
    status: res.status,
    message: res.message,
    servers: List<Server>.from(res.body["ServerList"].map((x) => Server.fromJson(x))),
  );
}
