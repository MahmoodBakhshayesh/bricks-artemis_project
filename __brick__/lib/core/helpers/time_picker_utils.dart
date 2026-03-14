import 'package:flutter/material.dart';

import '../extensions/context_extension.dart';

class TimePickerUtils {
  static Future<TimeOfDay?> show(
    BuildContext context, {
    String? title,
    TimeOfDay? initialTime,
    TimePickerEntryMode timePickerEntryMode = TimePickerEntryMode.dial,
  }) {
    return showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      helpText: title,
      confirmText: context.localizations.confirm,
      cancelText: context.localizations.cancel,
      initialEntryMode: timePickerEntryMode,
      hourLabelText: context.localizations.hour,
      minuteLabelText: context.localizations.minute,
    );
  }
}
