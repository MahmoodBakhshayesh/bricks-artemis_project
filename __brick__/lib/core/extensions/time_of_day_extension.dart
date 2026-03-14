import 'package:flutter/material.dart';

import 'int_extension.dart';

extension TimeOfDayExt on TimeOfDay {
  Duration get toDuration => Duration(hours: hour, minutes: minute);
}

extension TimeOfDayParsingExtension on TimeOfDay {
  String? get toJson {
    return '${hour.withTwoNumberFormat}:${minute.withTwoNumberFormat}';
  }
}

class TimeOfDayParser {
  static TimeOfDay? tryParse(String? stringValue) {
    if (stringValue == null || stringValue.isEmpty || stringValue.contains(':') == false) return null;

    final split = stringValue.split(':');

    if (split.length < 2) return null;

    try {
      return TimeOfDay(hour: int.parse(split[0]), minute: int.parse(split[1]));
    } catch (e) {
      return null;
    }
  }
}
