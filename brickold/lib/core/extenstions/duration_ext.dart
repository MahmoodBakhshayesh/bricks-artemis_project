import 'package:flutter/material.dart';

extension DurationExt on Duration {
  TimeOfDay get toTime => TimeOfDay(hour: inHours, minute: inMinutes - (inHours*60));
}