sealed class Result<T> {
  const Result();

  bool get isOk => this is Ok<T>;

  bool get isErr => this is Err<T>;

  T get require => (this as Ok<T>).value;

  Failure get error => (this as Err<T>).error;

  R fold<R>({required R Function(T response) ok, required R Function(Failure failure) err}) => switch (this) {
    Ok<T>(:final value) => ok(value),
    Err<T>(:final error) => err(error),
  };
}

final class Ok<T> extends Result<T> {
  const Ok(this.value);

  final T value;

  @override
  String toString() => 'Ok($value)';
}

final class Err<T> extends Result<T> {
  const Err(this.error);

  @override
  final Failure error;

  @override
  String toString() => 'Err($error)';
}

abstract class Failure {
  final String message;
  final Object? cause;
  final StackTrace? stackTrace;

  const Failure(this.message, {this.cause, this.stackTrace});

  @override
  // String toString() => '$runtimeType($message)';
  String toString() => message;
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

class ServerFailure extends Failure {
  final int? statusCode;
  final dynamic body;

  const ServerFailure(super.message, {this.statusCode, this.body, super.cause, super.stackTrace});
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message, {super.cause, super.stackTrace});
}

extension ResultX<T> on Result<T> {
  void onOk(void Function(T response) response) {
    if (this is Ok<T>) response((this as Ok<T>).value);
  }

  void onErr(void Function(Failure failure) failure) {
    if (this is Err<T>) failure((this as Err<T>).error);
  }

  T? okOrNull() => this is Ok<T> ? (this as Ok<T>).value : null;

  Failure? errorOrNull() => this is Err<T> ? (this as Err<T>).error : null;
}

class NetworkFailure extends Failure {
  final int? code;
  final String? method; // GET/POST/...
  final String? url; // absolute or relative
  final Duration? duration;
  final Map<String, dynamic>? response;
  final bool tokenExpired;
  final bool isTimeout;
  final bool isConnection;

  const NetworkFailure(
    super.message, {
    this.response,
    this.code,
    this.method,
    this.url,
    this.duration,
    this.tokenExpired = false,
    this.isTimeout = false,
    this.isConnection = false,
  });

  /// Render a short readable line. URL is optional, controlled by flags below.
  @override
  String toString() {
    final b = StringBuffer();

    if (method != null) b.write(method);
    if (method != null && _showUrlInUi && url != null) b.write(' ');
    if (_showUrlInUi && url != null) b.write(_prettyUrl(url!, includeQuery: _includeQueryParams));

    if (code != null) {
      if (b.isNotEmpty) b.write(' — ');
      b.write(code);
    }

    if (message.isNotEmpty) {
      if (b.isNotEmpty) b.write(' ');
      b.write(_short(message, max: 140));
    }

    if (duration != null) {
      b.write(' (${_fmt(duration!)})');
    }

    if (response != null) {
      b.write(response.toString());
    }

    return b.isEmpty ? 'Network error' : b.toString();
  }

  // --- Config knobs (can be toggled via ApiService at init) ---
  static bool _showUrlInUi = false; // default off (turn on in dev)
  static bool _includeQueryParams = false; // hide query by default

  static void configure({bool? showUrlInUi, bool? includeQueryParams}) {
    if (showUrlInUi != null) _showUrlInUi = showUrlInUi;
    if (includeQueryParams != null) _includeQueryParams = includeQueryParams;
  }

  // --- Builders ---
  static NetworkFailure fromResponse({
    required String method,
    required String url,
    required int? code,
    required String message,
    required Duration duration,
    bool tokenExpired = false,
  }) {
    return NetworkFailure(message, code: code, method: method, url: url, duration: duration, tokenExpired: tokenExpired);
  }

  static NetworkFailure fromException(Object error, {String? fallbackMessage}) {
    // Best effort extraction from DioException / RequestOptions
    String? method;
    String? url;
    int? code;
    String msg = fallbackMessage ?? 'Network error';
    bool timeout = false;
    bool connection = false;
    bool expired = false;

    try {
      // Avoid importing Dio types here; keep it reflective to not couple layers.
      final typeName = error.runtimeType.toString();
      if (typeName.contains('DioException')) {
        final req = (error as dynamic).requestOptions;
        method = req?.method;
        url = req?.uri?.toString();
        code = (error as dynamic)._loginResponse?.statusCode as int?;
        msg = (error as dynamic).message?.toString() ?? msg;

        final eType = (error as dynamic).type?.toString() ?? '';
        timeout = eType.contains('timeout');
        connection = eType.contains('connection');
      }

      // If you wrap into NetworkException, expose its fields
      if (typeName.contains('NetworkException')) {
        code = (error as dynamic).statusCode as int?;
        expired = (error as dynamic).tokenExpired as bool? ?? false;
        final raw = (error as dynamic).raw;
        if (raw != null && raw.runtimeType.toString().contains('DioException')) {
          final req = (raw as dynamic).requestOptions;
          method ??= req?.method;
          url ??= req?.uri?.toString();
        }
      }
    } catch (_) {
      /* swallow */
    }

    return NetworkFailure(
      _short(msg, max: 140),
      code: code,
      method: method,
      url: url,
      duration: null,
      tokenExpired: expired,
      isTimeout: timeout,
      isConnection: connection,
    );
  }
}

class UnAuthenticateFailure extends Failure {
  UnAuthenticateFailure(super.message);
}

// --- Helpers ---
String _short(String? s, {int max = 140}) {
  if (s == null) return '';
  final t = s.trim();
  return t.length <= max ? t : '${t.substring(0, max)}…';
}

String _fmt(Duration d) {
  if (d.inMilliseconds < 1000) return '${d.inMilliseconds}ms';
  final ms = d.inMilliseconds % 1000;
  return '${d.inSeconds}.${(ms / 100).floor()}s';
}

String _prettyUrl(String raw, {bool includeQuery = false}) {
  // Hide scheme/host noise; keep path; optionally query (masked).
  try {
    final u = Uri.parse(raw);
    final path = u.path.isEmpty ? '/' : u.path;
    if (!includeQuery || u.query.isEmpty) return path;
    // mask common sensitive params
    final masked = u.queryParameters.map((k, v) {
      final lower = k.toLowerCase();
      final hide = lower.contains('token') || lower.contains('key') || lower.contains('auth') || lower.contains('sig');
      return MapEntry(k, hide ? '***' : v);
    });
    return Uri(path: path, queryParameters: masked).toString();
  } catch (_) {
    return raw; // fallback
  }
}
