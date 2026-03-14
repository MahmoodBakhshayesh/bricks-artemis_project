import 'package:flutter/material.dart';

extension TimeOfDayExt on TimeOfDay {
  Duration get toDuration => Duration(hours:hour,minutes: minute);
}