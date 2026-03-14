import '../../di.dart';
import '../../widgets/overlays/token_expire_overlay.dart';
import '../interfaces/api_state.dart';
import '../interfaces/base_overlays_helper.dart';
import '../interfaces/base_result.dart';

/// A reusable helper mixin that standardizes the lifecycle of API calls.
///
/// Responsibilities:
/// - Emit loading state (optional)
/// - Execute an API call that returns a [Result]
/// - Convert success responses to UI data
/// - Emit success or failure as an [ApiState]
///
/// What this mixin deliberately does NOT do:
/// - It does not own or mutate ViewState directly
/// - It does not call `setState`
/// - It does not handle concurrency or cancellation
/// - It does not swallow or rethrow errors
///
/// State ownership remains in the provider.
/// This mixin only coordinates async flow.
class BaseController {
  /// Executes an API request and emits its lifecycle as [ApiState].
  ///
  /// Typical flow:
  /// 1. Emit `ApiState.loading()` (if [emitLoading] is true)
  /// 2. Await the API call
  /// 3. Emit `ApiState.success(data)` on success
  /// 4. Emit `ApiState.failed(failure)` on error
  ///
  /// Type parameters:
  /// - [ResponseType]: Raw response type returned from the repository or data source
  /// - [SuccessType]: Mapped domain or UI-friendly type exposed to the ViewState
  ///
  /// Parameters:
  /// - [apiCall]:
  ///   A function that performs the API request.
  ///   Must return a [Result] and must NOT throw.
  ///
  /// - [emitState]:
  ///   A callback used to emit the computed [ApiState].
  ///   Typically wraps `setState` inside the provider.
  ///
  /// - [dataMapper]:
  ///   Transforms the raw response [ResponseType] into the desired success type [SuccessType].
  ///   This keeps DTOs out of the ViewState layer.
  ///
  /// - [emitLoading]:
  ///   Controls whether `ApiState.loading()` is emitted before executing
  ///   the API call. Useful for refresh or silent updates.
  ///
  /// Contract:
  /// - All failures must be represented as [Failure] inside [Result.err]
  /// - This method emits exactly one terminal state: success or failure
  Future<Result<ResponseType>> handleApiRequest<ResponseType, SuccessType>({
    required Future<Result<ResponseType>> Function() apiCall,
    required void Function(ApiState<SuccessType> apiState) emitState,
    required SuccessType Function(ResponseType response) dataMapper,
    bool emitLoading = true,
    bool shouldRefreshOnUnAuthenticate = false,
  }) async {
    // Emit loading state if requested
    if (emitLoading) {
      emitState(const ApiState.loading());
    }

    // Execute the API call
    final result = await apiCall();

    /// check if api-call return [UnAuthenticateFailure]
    if (result.isErr && result.error is UnAuthenticateFailure) {
      /// emit [ApiRequestStatus.unAuthenticate] so UI stop loadingWidget.
      emitState(ApiState.unAuthenticate());

      /// open [TokenExpireOverlay] if not mounted.
      final overlayHelper = locator<BaseOverlaysHelper>();
      if (overlayHelper.alertKey.currentContext != null && overlayHelper.alertKey.currentContext?.mounted == true) {
        return Err(result.error);
      }

      /// if login was successful, the TokenExpireOverlay will pop with true.
      /// otherwise it will be null
      final reLoginSuccessful = await overlayHelper.showAppDialog<bool?>(
        (context) => const TokenExpireOverlay(),
        barrierDismissible: false,
      );

      /// if user successfully logged in from [TokenExpireOverlay], then refresh the api call.
      /// otherwise the error will be returned.
      /// at least check if we want to Refresh api-call when login was successful.
      /// TODO: need to check if user logged in with the same account.
      if (reLoginSuccessful == true && shouldRefreshOnUnAuthenticate == true) {
        return handleApiRequest(apiCall: apiCall, emitState: emitState, dataMapper: dataMapper);
      }
    }

    // Emit the final state based on the result
    result.fold(
      ok: (response) => emitState(ApiState.success(dataMapper(response))),
      err: (failure) => emitState(ApiState.failed(failure)),
    );

    return result;
  }
}
