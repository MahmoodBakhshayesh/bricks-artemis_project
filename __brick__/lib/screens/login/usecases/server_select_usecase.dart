import 'package:dartz/dartz.dart';
import '../../../core/abstracts/failures_abs.dart';
import '../../../core/abstracts/request_abs.dart';
import '../../../core/abstracts/response_abs.dart';
import '../../../core/abstracts/usecase_abs.dart';
import '../../../core/classes/server_class.dart';
import '../login_repository.dart';

class ServerSelectUseCase extends UseCase<ServerSelectResponse, ServerSelectRequest> {
  ServerSelectUseCase();

  @override
  Future<Either<Failure, ServerSelectResponse>> call({required ServerSelectRequest request}) {
    if (request.validate() != null) return Future(() => Left(request.validate()!));
    LoginRepository repository = LoginRepository();
    return repository.serverSelect(request);
  }
}

class ServerSelectRequest extends Request {
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

class ServerSelectResponse extends Response {
  final List<Server> servers;

  ServerSelectResponse({required int status, required String message, required this.servers}) : super(status: status, message: message, body: {"ServerList": servers.map((e) => e.toJson()).toList()});

  factory ServerSelectResponse.fromResponse(Response res) => ServerSelectResponse(
        status: res.status,
        message: res.message,
        servers: List<Server>.from(res.body["ServerList"].map((x) => Server.fromJson(x))),
      );
}
