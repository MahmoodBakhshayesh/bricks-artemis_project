import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'base_result.dart';

/// Immutable base state interface (optional – for consistency).
class ApiState<T> {
  final ApiRequestStatus status;
  final T? data;
  final Failure? error;

  bool get isLoading => status == ApiRequestStatus.loading;

  bool get isOk => status == ApiRequestStatus.success;

  bool get isError => status == ApiRequestStatus.error;

  const ApiState({required this.status, this.data, this.error});

  const ApiState.notStarted({this.data}) : error = null, status = ApiRequestStatus.notStarted;

  const ApiState.loading({this.data}) : error = null, status = ApiRequestStatus.loading;

  const ApiState.success(this.data) : error = null, status = ApiRequestStatus.success;

  const ApiState.failed(this.error, {this.data}) : status = ApiRequestStatus.error;

  const ApiState.unAuthenticate({this.data, this.error}) : status = ApiRequestStatus.unAuthenticate;

  ApiState copyWith({required ApiRequestStatus status, T? data, Failure? error}) => ApiState(status: status, data: data, error: error);
}

/// Generic simple status wrapper you can reuse if you like.
enum ApiRequestStatus { notStarted, loading, success, error, unAuthenticate }

extension ApiStateWhenX<T> on ApiState<T> {
  /// Pattern-matching helper similar to `AsyncValue.when()`.
  ///
  /// - [loadingBuilder]: builder called when `status == LoadStatus.loading`
  /// - [errorBuilder]: builder called when `status == LoadStatus.error`
  /// - [successBuilder]: builder called when `status == LoadStatus.success`
  /// - [notStartedBuilder]: optional builder for initial/notStarted state
  ///
  /// Example:
  /// ```dart
  /// state.when(
  ///   loading: () => const CircularProgressIndicator(),
  ///   error: (msg) => Text(msg ?? 'Error'),
  ///   data: (passenger) => PassengerCard(passenger),
  /// );
  /// ```
  Widget when({
    Widget Function()? loadingBuilder,
    Widget Function(Failure? err)? errorBuilder,
    required Widget Function(T data) successBuilder,
    Widget Function()? notStartedBuilder,
    AsyncCallback? onTryAgain,
  }) {
    Widget? statusWidget = switch (status) {
      .notStarted => notStartedBuilder?.call(),
      .loading => loadingBuilder != null ? loadingBuilder() : const CircularProgressIndicator(),
      .success => successBuilder(data as T),
      .error =>
        errorBuilder != null
            ? errorBuilder(error)
            : Center(
                child: Text("onTryAgain: onTryAgain, error: error"),
              ),

      /// show nothing on [unAuthenticate]
      /// if the TokenExpireDialog isDismissible, then you must return TryAgain widget for unAuthenticate.
      ApiRequestStatus.unAuthenticate => null,
    };

    return statusWidget ?? const SizedBox.shrink();
  }
}
