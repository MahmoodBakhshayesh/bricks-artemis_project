import 'package:flutter/material.dart';

class Pickers {
  Pickers._();

  static Future<TimeOfDay?> pickTime(BuildContext context, TimeOfDay time) {
    return showTimePicker(
      context: context,
      initialTime: time,
      initialEntryMode: TimePickerEntryMode.input,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
  }

  static Future<DateTime?> pickDate(BuildContext context, DateTime dateTime, {DateTime? minDate, DateTime? maxDate}) {
    return showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: minDate ?? DateTime.now().subtract(const Duration(days: 100)),
      lastDate: maxDate ?? DateTime.now().add(const Duration(days: 100)),
    );
  }
}
