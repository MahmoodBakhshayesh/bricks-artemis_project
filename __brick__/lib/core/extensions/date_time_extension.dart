import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime? {
  String? get toRequest {
    if (this == null) return null;
    return DateFormat('yyyy-MM-dd').format(this!);
  }

  /// return true if device time is correct comparing with currentServerTime.
  bool isDeviceTimeCorrect(DateTime currentServerTime) {
    if (this == null) return false;

    final difference = this!.difference(currentServerTime);
    return (difference.inHours <= 2);
  }
}
