import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../data/app_data.dart';
import '../helpers/logger_service.dart';
import '../helpers/network_exception.dart';
import '../helpers/networking_typedef.dart';
import '../models/base/flavor_config.dart';
import '../models/networking/http_method.dart';
import '../models/networking/network_request.dart';
import '../models/networking/network_response.dart';
import '../models/networking/retry_policy.dart';

class ApiService {
  late final Dio _dio;

  // Global settings
  final Duration connectTimeout;
  final Duration receiveTimeout;
  Map<String, dynamic> defaultHeaders = {'content-type': 'application/json', 'Accept': 'application/json'};
  final RetryPolicy retryPolicy;
  final int maxRetries;
  final bool throwOnFailureGlobal;

  // Hooks
  void Function(NetworkRequest req)? onStart;
  NetworkHook? onEnd;
  NetworkHook? onSuccess;
  NetworkHook? onFailed;
  NetworkHook? onTokenExpire;

  // Checks
  NetworkCheck? successCheck;
  NetworkCheck? failedCheck;
  NetworkCheck? tokenExpireCheck;
  NetworkMessageExtractor? messageExtractor;

  ApiService({
    Map<String, dynamic> additionalHeaders = const {},
    this.connectTimeout = const Duration(minutes: 2),
    this.receiveTimeout = const Duration(minutes: 2),
    this.retryPolicy = RetryPolicy.exponential,
    this.maxRetries = 2,
    this.throwOnFailureGlobal = true,
    this.onStart,
    this.onEnd,
    this.onSuccess,
    this.onFailed,
    this.onTokenExpire,
    this.successCheck,
    this.failedCheck,
    this.tokenExpireCheck,
    this.messageExtractor,
  }) {
    _dio = Dio(
      BaseOptions(
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        headers: defaultHeaders..addAll(additionalHeaders),
        responseType: ResponseType.json,
        followRedirects: true,
        maxRedirects: maxRetries,
        validateStatus: (code) => code != null && code >= 200 && code < 300,
      ),
    );

    if (kReleaseMode == false) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          // filter: (options, args) => args.data.toString().length < 1000,
        ),
      );
    }
  }

  factory ApiService.appDefault({NetworkHook? onTokenExpire}) {
    return ApiService(
      retryPolicy: RetryPolicy.none,
      messageExtractor: (json) => json['message']?.toString() ?? json['error_description']?.toString(),
      successCheck: (req, res) {
        final m = res.data is Map ? (res.data as Map) : const {};
        final httpOk = (res.statusCode != null && res.statusCode! >= 200 && res.statusCode! < 300);
        final businessOk =true|| ((m['status'] ?? m['success']) == true) || (m['code'] == 0) || (m['Message'] == 'Done');
        return httpOk && (m.isEmpty || businessOk);
      },
      failedCheck: (req, res) {
        final httpOk = (res.statusCode != null && res.statusCode! >= 200 && res.statusCode! < 300);
        return !httpOk;
        if ((res.data is Map) && (res.data as Map)['Message'] != 'Done') return true;

        final m = res.data is Map ? (res.data as Map) : const {};
        return m['success'] == false;
      },
      tokenExpireCheck: (req, res) {
        final m = res.data is Map ? (res.data as Map) : const {};
        return res.statusCode == 401 || m['Status'] == -999;
      },
      onTokenExpire: (req, res) {
        appLog.w('Token expired on ${req.pathOrUrl}');
        onTokenExpire?.call(req, res);
      },
    );
  }

  // ========================================================================
  // PUBLIC HELPERS (typed verbs)
  // ========================================================================

  Future<NetworkResponse> get(
    String pathOrUrl, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    Duration? timeout,
    bool? enableLogs,
    bool? throwOnFailure,
    CancelToken? cancelToken,
  }) => _request(
    HttpMethod.get,
    pathOrUrl,
    query: query,
    headers: headers,
    timeout: timeout,
    enableLogs: enableLogs,
    throwOnFailure: throwOnFailure,
    cancelToken: cancelToken,
  );

  Future<NetworkResponse> post(
    String pathOrUrl, {
    dynamic body,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    Duration? timeout,
    bool? enableLogs,
    bool? throwOnFailure,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) => _request(
    HttpMethod.post,
    pathOrUrl,
    body: body,
    query: query,
    headers: headers,
    timeout: timeout,
    enableLogs: enableLogs,
    throwOnFailure: throwOnFailure,
    onSendProgress: onSendProgress,
    onReceiveProgress: onReceiveProgress,
    cancelToken: cancelToken,
  );

  Future<NetworkResponse> put(
    String pathOrUrl, {
    dynamic body,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    Duration? timeout,
    bool? enableLogs,
    bool? throwOnFailure,
    CancelToken? cancelToken,
  }) => _request(
    HttpMethod.put,
    pathOrUrl,
    body: body,
    query: query,
    headers: headers,
    timeout: timeout,
    enableLogs: enableLogs,
    throwOnFailure: throwOnFailure,
    cancelToken: cancelToken,
  );

  Future<NetworkResponse> patch(
    String pathOrUrl, {
    dynamic body,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    Duration? timeout,
    bool? enableLogs,
    bool? throwOnFailure,
    CancelToken? cancelToken,
  }) => _request(
    HttpMethod.patch,
    pathOrUrl,
    body: body,
    query: query,
    headers: headers,
    timeout: timeout,
    enableLogs: enableLogs,
    throwOnFailure: throwOnFailure,
  );

  Future<NetworkResponse> delete(
    String pathOrUrl, {
    dynamic body,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    Duration? timeout,
    bool? enableLogs,
    bool? throwOnFailure,
    CancelToken? cancelToken,
  }) => _request(
    HttpMethod.delete,
    pathOrUrl,
    body: body,
    query: query,
    headers: headers,
    timeout: timeout,
    enableLogs: enableLogs,
    throwOnFailure: throwOnFailure,
    cancelToken: cancelToken,
  );

  Future<NetworkResponse> upload(
    String pathOrUrl, {
    required FormData formData,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    Duration? timeout,
    bool? enableLogs,
    bool? throwOnFailure,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) => _request(
    HttpMethod.upload,
    pathOrUrl,
    body: formData,
    query: query,
    headers: {'Content-Type': 'multipart/form-data', ...?headers},
    timeout: timeout,
    enableLogs: enableLogs,
    throwOnFailure: throwOnFailure,
    onSendProgress: onSendProgress,
    onReceiveProgress: onReceiveProgress,
    cancelToken: cancelToken,
  );

  Future<NetworkResponse> download(
    String url,
    String savePath, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    bool? enableLogs,
    bool? throwOnFailure,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    final req = NetworkRequest(HttpMethod.download, url, query, headers, null, enableLogs);
    onStart?.call(req);
    final sw = Stopwatch()..start();
    final shouldThrow = throwOnFailure ?? throwOnFailureGlobal;

    final path = url.startsWith('http') ? url : '${appConfig.baseUrl}$url';

    try {
      await _dio.download(
        path,
        cancelToken: cancelToken,
        savePath,
        queryParameters: query,
        options: Options(headers: _composeHeaders(headers)),
        onReceiveProgress: onReceiveProgress,
      );

      final res = NetworkResponse(
        success: true,
        statusCode: 200,
        message: 'Download complete',
        data: {'path': savePath},
        raw: null,
        duration: sw.elapsed,
      );
      onSuccess?.call(req, res);
      onEnd?.call(req, res);
      return res;
    } catch (e, st) {
      return _handleFailedRequest(req, e, st, sw.elapsed, shouldThrow);
    }
  }

  // ========================================================================
  // CORE REQUEST PIPELINE
  // ========================================================================

  Future<NetworkResponse> _request(
    HttpMethod method,
    String pathOrUrl, {
    dynamic body,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    Duration? timeout,
    bool? enableLogs,
    bool? throwOnFailure,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    final req = NetworkRequest(method, pathOrUrl, query, headers, body, enableLogs);
    onStart?.call(req);
    final sw = Stopwatch()..start();
    final shouldThrow = throwOnFailure ?? throwOnFailureGlobal;

    for (int attempt = 0; attempt <= maxRetries; attempt++) {
      try {
        final path = pathOrUrl.startsWith('http') ? pathOrUrl : '${appConfig.baseUrl}$pathOrUrl';

        final response = await _dio.request(
          path,
          data: body,
          cancelToken: cancelToken,
          queryParameters: query,
          options: Options(
            method: method.name,
            headers: _composeHeaders(headers),
            receiveTimeout: timeout ?? receiveTimeout,
            sendTimeout: timeout ?? connectTimeout,
          ),
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        );

        return _handleSuccessfulResponse(req, response, sw.elapsed, shouldThrow);
      } on DioException catch (e, st) {
        if (_shouldRetry(e, attempt)) {
          final delay = Duration(milliseconds: 200 * pow(2, attempt + 1).toInt());
          await Future.delayed(delay);
          continue; // Move to the next attempt
        }
        return _handleFailedRequest(req, e, st, sw.elapsed, shouldThrow);
      } on NetworkException catch (e) {
        return _handleFailedRequest(req, e, null, sw.elapsed, shouldThrow, data: e.data);
      } catch (e, st) {
        return _handleFailedRequest(req, e, st, sw.elapsed, shouldThrow);
      }
    }

    // This is only reached if all retries fail.
    throw NetworkException(message: 'Request failed after $maxRetries retries');
  }

  // ========================================================================
  // PRIVATE HELPERS
  // ========================================================================

  /// Handles responses that were successfully received from the server.
  NetworkResponse _handleSuccessfulResponse(
    NetworkRequest req,
    Response dioResponse,
    Duration duration,
    bool shouldThrow,
  ) {
    final res = _parseResponse(req, dioResponse, duration);

    if (res.success) {
      onSuccess?.call(req, res);
      onEnd?.call(req, res);
      return res;
    } else if (tokenExpireCheck?.call(req, res) ?? false) {
      onTokenExpire?.call(req, res);
      onEnd?.call(req, res);
      if (shouldThrow) {
        throw NetworkException(
          statusCode: res.statusCode,
          message: res.message ?? 'Token expired',
          data: res.data,
          raw: dioResponse,
          tokenExpired: true,
        );
      }
      return res;
    } else {
      onFailed?.call(req, res);
      onEnd?.call(req, res);
      if (shouldThrow) {
        throw NetworkException(
          statusCode: res.statusCode,
          message: res.message ?? 'Request failed',
          data: res.data,
          raw: dioResponse,
        );
      }
      return res;
    }
  }

  /// Handles exceptions thrown during the request.
  NetworkResponse _handleFailedRequest(
    NetworkRequest req,
    Object e,
    StackTrace? st,
    Duration duration,
    bool shouldThrow, {
    int? statusCode,
    Map<String, dynamic>? data,
  }) {
    final NetworkResponse res;
    switch (e.runtimeType) {
      case DioException e:
        res = _wrapError(req, e, duration);
        break;

      default:
        res = NetworkResponse(
          statusCode: statusCode,
          success: false,
          message: e.toString(),
          data: data,
          raw: e,
          duration: duration,
        );
    }

    onFailed?.call(req, res);
    onEnd?.call(req, res);

    if (shouldThrow) {
      if (e is DioException) {
        /// if request was canceled by us.
        if (e.type == DioExceptionType.cancel) throw NetworkException(message: 'Request Cancelled.', wasCancelled: true);
        throw _handleDioException(e, res);
      } else {
        throw e;
        // throw NetworkException(
        //   statusCode: res.statusCode,
        //   message: res.message ?? 'Unknown error',
        //   data: res.data,
        //   raw: e,
        // );
      }
    }
    return res;
  }

  Map<String, dynamic> _composeHeaders(Map<String, dynamic>? override) {
    final all = <String, dynamic>{};
    all.addAll(defaultHeaders);
    if (AppData.instance.hasToken) all['Authorization'] = 'Bearer ${AppData.instance.token}';
    if (override != null) all.addAll(override);
    return all;
  }

  bool _shouldRetry(DioException e, int attempt) {
    if (attempt >= maxRetries) return false;
    if (retryPolicy != RetryPolicy.exponential) return false;

    return e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.connectionError ||
        (e.response?.statusCode ?? 0) >= 500;
  }

  NetworkResponse _wrapError(NetworkRequest req, DioException e, Duration duration) {
    return NetworkResponse(
      success: false,
      statusCode: e.response?.statusCode ?? -1,
      message: e.message ?? 'Network error',
      data: e.response?.data,
      raw: e,
      duration: duration,
    );
  }

  NetworkResponse _parseResponse(NetworkRequest req, Response response, Duration duration) {
    final statusCode = response.statusCode;
    dynamic data = response.data;

    if (data is String) {
      try {
        data = jsonDecode(data);
      } catch (_) {
        // Keep raw string if not JSON.
      }
    }

    final msg =
        messageExtractor?.call(data is Map<String, dynamic> ? data : {}) ??
        (data is Map<String, dynamic> ? (data['Message'] ?? data['error'] ?? data['msg'])?.toString() : null) ??
        'Please contact support.';

    final initial = NetworkResponse(
      success: statusCode != null && statusCode >= 200 && statusCode < 300,
      statusCode: statusCode,
      message: msg,
      data: data,
      raw: response,
      duration: duration,
    );

    if (!(successCheck?.call(req, initial) ?? true)) {
      return initial.copyWith(success: false);
    }
    if (failedCheck?.call(req, initial) ?? false) {
      return initial.copyWith(success: false);
    }
    if (tokenExpireCheck?.call(req, initial) ?? false) {
      return initial.copyWith(success: false, message: 'Token expired');
    }

    return initial;
  }

  NetworkException _handleDioException(DioException e, NetworkResponse res) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return NetworkException(
          message: 'Connection timed out. Please check your internet connection.',
          statusCode: res.statusCode,
          raw: e,
        );
      case DioExceptionType.sendTimeout:
        return NetworkException(
          message: 'Request timed out while sending data. Please try again.',
          statusCode: res.statusCode,
          raw: e,
        );
      case DioExceptionType.receiveTimeout:
        return NetworkException(
          message: 'Response timed out. The server might be busy or you may have a poor connection.',
          statusCode: res.statusCode,
          raw: e,
        );
      case DioExceptionType.badCertificate:
        return NetworkException(
          message: 'Invalid SSL certificate. Please contact support.',
          statusCode: res.statusCode,
          raw: e,
        );
      case DioExceptionType.badResponse:
        return NetworkException(
          message: 'The server returned an unexpected response. Please try again later.',
          statusCode: res.statusCode,
          data: res.data,
          raw: e,
        );
      case DioExceptionType.cancel:
        return NetworkException(
          message: 'The request was cancelled.',
          statusCode: res.statusCode,
          raw: e,
        );
      case DioExceptionType.connectionError:
        return NetworkException(
          message: 'Connection error. Please check your internet connection and try again.',
          statusCode: res.statusCode,
          raw: e,
        );
      case DioExceptionType.unknown:
        return NetworkException(
          message: 'An unknown network error occurred. Please try again.',
          statusCode: res.statusCode,
          raw: e,
        );
    }
  }
}

