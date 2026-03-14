import 'package:dio/dio.dart';
import '../data/app_data.dart';
import '../helpers/network_exception.dart';
import 'base_failure.dart';
import 'base_result.dart';

/// Request objects implement `validate()` if needed.
abstract class Request {
  final cancelToken = CancelToken();

  /// Return a Failure to stop the use case, or null if valid.
  Failure? validate();

  Map<String, dynamic> toJson();

  static Map<String, dynamic> createRequestJson({required String execution, required Map<String, dynamic>? body}) {
    Map<String, dynamic> requestBody = {
      if (AppData.instance.hasToken) 'Token': AppData.instance.token,
      'Request': {
        ...?body,
      },
    };

    return {
      'Body': {'Execution': execution, ...requestBody},
    };
  }
}

/// Optional response marker (handy for typing/mapping).
abstract class UseCaseResponse {
  const UseCaseResponse();
}

abstract class UseCase<Out extends Object, In extends Request> {
  const UseCase();

  /// report error to [FailurePresenter] to show toast.
  /// can be override to show custom error message.
  void customErrorHandler(NetworkException networkException) {
    if (networkException.wasCancelled != true) {
      FailureBus.I.emit(FailureNotice.fromNetworkException(networkException));
    }
  }

  /// Template method: validates first, then runs `exec`.
  Future<Result<Out>> call(In request) async {
    final v = request.validate();
    if (v != null) {
      FailureBus.I.emit(FailureNotice(failure: v));
      return Err(v);
    }
    try {
      final out = await exec(request);
      return Ok(out);
    } on NetworkException catch (networkException) {
      customErrorHandler(networkException);

      /// if token was expired, then return [UnAuthenticateFailure].
      /// it will be catch and handled in [ApiHandlerHook]
      if (networkException.tokenExpired == true) {
        return Err(UnAuthenticateFailure(networkException.message));
      }
      return Err(NetworkFailure(networkException.message, code: networkException.statusCode, response: networkException.data));
    } catch (e, st) {
      // If your repo already throws typed exceptions, map them here if needed.
      FailureBus.I.emit(
        FailureNotice(
          failure: UnknownFailure(e.toString(), cause: e, stackTrace: st),
        ),
      );
      if (e is Failure) {
        return Err(e);
      }
      return Err(UnknownFailure(e.toString(), cause: e, stackTrace: st));
    }
  }

  Future<Out> exec(In request);
}
