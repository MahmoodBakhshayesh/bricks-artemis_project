import '../../../core/interfaces/base_result.dart';
import '../../../core/interfaces/base_usecase.dart';
import '../domain/entities/user_entity.dart';
import '../domain/interfaces/login_repository_interface.dart';

class LoginRequest extends Request {
  final String username;
  final String password;

  LoginRequest({required this.username, required this.password});

  @override
  Failure? validate() => null;
  
  @override
  Map<String, dynamic> toJson() => {};
}

class LoginResponse extends UseCaseResponse {
  final bool success;
  final UserEntity? user;
  final String message;

  LoginResponse({required this.success, this.user, this.message = ''});
}

class LoginUsecase extends UseCase<LoginResponse, LoginRequest> {
  final LoginRepositoryInterface _repository;

  LoginUsecase(this._repository);

  @override
  Future<LoginResponse> exec(LoginRequest request) async {
    return _repository.login(request.username, request.password);
  }
}
