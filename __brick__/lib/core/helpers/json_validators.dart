import 'package:flutter/material.dart';

//
// ===========================================================
//  PUBLIC JSON VALIDATION HELPERS (with optional default values)
// ===========================================================
//

// --------------------
// INTERNAL ERRORS
// --------------------
Never throwTypeError(String expected, String key, Object? value) {
  final actual = value == null ? 'null' : value.runtimeType.toString();
  throw FormatException(
    "Expected non-null $expected for '$key', but got $actual.",
  );
}

// --------------------
// PRIMITIVE TYPES
// --------------------

String expectString(Map<String, dynamic> json, String key, {String? defaultValue}) {
  final v = json[key];
  if (v == null) {
    if (defaultValue != null) return defaultValue;
    throwTypeError('String', key, v);
  }
  if (v is! String) throwTypeError('String', key, v);
  return v;
}

int expectInt(Map<String, dynamic> json, String key, {int? defaultValue}) {
  final v = json[key];
  if (v == null) {
    if (defaultValue != null) return defaultValue;
    throwTypeError('int', key, v);
  }

  if (v is int) return v;

  // allow double → int if exact
  if (v is double && v == v.roundToDouble()) {
    return v.toInt();
  }

  throwTypeError('int', key, v);
}

double expectDouble(Map<String, dynamic> json, String key, {double? defaultValue}) {
  final v = json[key];
  if (v == null) {
    if (defaultValue != null) return defaultValue;
    throwTypeError('double', key, v);
  }

  if (v is double) return v;
  if (v is int) return v.toDouble();

  throwTypeError('double', key, v);
}

num expectNum(Map<String, dynamic> json, String key, {num? defaultValue}) {
  final v = json[key];
  if (v == null) {
    if (defaultValue != null) return defaultValue;
    throwTypeError('num', key, v);
  }
  if (v is num) return v;

  throwTypeError('num', key, v);
}

bool expectBool(Map<String, dynamic> json, String key, {bool? defaultValue}) {
  final v = json[key];
  if (v == null) {
    if (defaultValue != null) return defaultValue;
    throwTypeError('bool', key, v);
  }
  if (v is bool) return v;
  if (v is int) return v != 0;

  throwTypeError('bool', key, v);
}

// --------------------
// MAP & LIST TYPES
// --------------------

Map<String, dynamic> expectMap(
  Map<String, dynamic> json,
  String key, {
  Map<String, dynamic>? defaultValue,
}) {
  final v = json[key];

  if (v == null) {
    if (defaultValue != null) return defaultValue;
    throwTypeError('Map<String,dynamic>', key, v);
  }

  if (v is! Map) {
    throwTypeError('Map<String,dynamic>', key, v);
  }

  // ensure keys are valid strings
  return v.map((k, val) {
    if (k is! String) {
      throwTypeError('String (map key)', '$key.{key}', k);
    }
    return MapEntry(k, val);
  });
}

List<dynamic> expectList(
  Map<String, dynamic> json,
  String key, {
  List<dynamic>? defaultValue,
}) {
  final v = json[key];

  if (v == null) {
    if (defaultValue != null) return defaultValue;
    throwTypeError('List', key, v);
  }

  if (v is! List) throwTypeError('List', key, v);
  return v;
}

List<String> expectStringList(
  Map<String, dynamic> json,
  String key, {
  List<String>? defaultValue,
}) {
  final list = json[key];

  if (list == null) {
    if (defaultValue != null) return defaultValue;
    throwTypeError('List<String>', key, list);
  }

  if (list is! List) throwTypeError('List<String>', key, list);
  if (list.any((e) => e is! String)) {
    throwTypeError('List<String>', key, list);
  }

  return List<String>.from(list);
}

/// list of a specific type with conversion
List<T> expectListOf<T>(
  Map<String, dynamic> json,
  String key,
  T Function(dynamic raw) convert, {
  List<T>? defaultValue,
}) {
  final v = json[key];

  if (v == null) {
    if (defaultValue != null) return defaultValue;
    throwTypeError('List<$T>', key, v);
  }

  if (v is! List) throwTypeError('List<$T>', key, v);

  return v.map((e) => convert(e)).toList();
}

// --------------------
// ENUMS & SPECIAL TYPES
// --------------------

/// Enum via .name
T expectEnumByName<T extends Enum>(
  Map<String, dynamic> json,
  String key,
  List<T> values, {
  T? defaultValue,
}) {
  final raw = json[key];

  if (raw == null) {
    if (defaultValue != null) return defaultValue;
    throwTypeError('Enum', key, raw);
  }

  if (raw is! String) throwTypeError('Enum name (String)', key, raw);

  try {
    return values.firstWhere((e) => e.name == raw);
  } catch (_) {
    throw FormatException(
      "Invalid enum value '$raw' for '$key'. Expected one of: "
      "${values.map((e) => e.name).join(', ')}.",
    );
  }
}

/// DateTime in ISO-8601 string
DateTime expectDateTime(
  Map<String, dynamic> json,
  String key, {
  DateTime? defaultValue,
}) {
  final raw = json[key];

  if (raw == null) {
    if (defaultValue != null) return defaultValue;
    throwTypeError('ISO-8601 DateTime String', key, raw);
  }

  if (raw is! String) {
    throwTypeError('ISO-8601 DateTime String', key, raw);
  }

  try {
    return DateTime.parse(raw);
  } catch (_) {
    throw FormatException(
      "Invalid DateTime format for '$key': '$raw'",
    );
  }
}

TimeOfDay expectTimeOfDay(
  Map<String, dynamic> json,
  String key, {
  TimeOfDay? defaultValue,
}) {
  final raw = json[key];

  if (raw == null) {
    if (defaultValue != null) return defaultValue;
    throwTypeError('HH:mm TimeOfDay String', key, raw);
  }

  if (raw is! String) {
    throwTypeError('HH:mm TimeOfDay String', key, raw);
  }

  try {
    final parts = raw.split(':');
    if (parts.length != 2) {
      throw FormatException("Invalid TimeOfDay format for '$key': '$raw'. Expected HH:mm");
    }
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    if (hour < 0 || hour > 23 || minute < 0 || minute > 59) {
      throw FormatException("Invalid TimeOfDay value for '$key': '$raw'. Hour or minute out of range.");
    }
    return TimeOfDay(hour: hour, minute: minute);
  } catch (_) {
    throw FormatException(
      "Invalid TimeOfDay format for '$key': '$raw'. Expected HH:mm",
    );
  }
}

TimeOfDay? expectNullableTimeOfDay(
  Map<String, dynamic> json,
  String key,
) {
  final raw = json[key];
  if (raw == null) return null;

  if (raw is! String) {
    throwTypeError('HH:mm TimeOfDay String', key, raw);
  }

  try {
    final parts = raw.split(':');
    if (parts.length == 3 && int.tryParse(parts[2]) != null) {
      parts.removeLast();
    } else if (parts.length != 2) {
      throw FormatException("Invalid TimeOfDay format for '$key': '$raw'. Expected HH:mm");
    }
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    if (hour < 0 || hour > 23 || minute < 0 || minute > 59) {
      throw FormatException("Invalid TimeOfDay value for '$key': '$raw'. Hour or minute out of range.");
    }
    return TimeOfDay(hour: hour, minute: minute);
  } catch (_) {
    throw FormatException(
      "Invalid TimeOfDay format for '$key': '$raw'. Expected HH:mm",
    );
  }
}

// --------------------
// Nullable TYPES
// --------------------

String? expectNullableString(Map<String, dynamic> json, String key) {
  final v = json[key];
  if (v == null) return null;
  if (v is! String) throwTypeError('String', key, v);
  return v;
}

int? expectNullableInt(Map<String, dynamic> json, String key) {
  final v = json[key];
  if (v == null) return null;

  if (v is int) return v;
  if (v is double && v == v.roundToDouble()) {
    return v.toInt();
  }

  throwTypeError('int', key, v);
}

double? expectNullableDouble(Map<String, dynamic> json, String key) {
  final v = json[key];
  if (v == null) return null;

  if (v is double) return v;
  if (v is int) return v.toDouble();

  throwTypeError('double', key, v);
}

num? expectNullableNum(Map<String, dynamic> json, String key) {
  final v = json[key];
  if (v == null) return null;
  if (v is num) return v;

  throwTypeError('num', key, v);
}

bool? expectNullableBool(Map<String, dynamic> json, String key) {
  final v = json[key];
  if (v == null) return null;
  if (v is bool) return v;
  if (v is int) return v != 0;

  throwTypeError('bool', key, v);
}

Map<String, dynamic>? expectNullableMap(
  Map<String, dynamic> json,
  String key,
) {
  final v = json[key];
  if (v == null) return null;

  if (v is! Map) {
    throwTypeError('Map<String,dynamic>', key, v);
  }

  return v.map((k, val) {
    if (k is! String) {
      throwTypeError('String (map key)', '$key.{key}', k);
    }
    return MapEntry(k, val);
  });
}

List<dynamic>? expectNullableList(
  Map<String, dynamic> json,
  String key,
) {
  final v = json[key];
  if (v == null) return null;
  if (v is! List) throwTypeError('List', key, v);
  return v;
}

List<String>? expectNullableStringList(
  Map<String, dynamic> json,
  String key,
) {
  final list = json[key];
  if (list == null) return null;

  if (list is! List) throwTypeError('List<String>', key, list);
  if (list.any((e) => e is! String)) {
    throwTypeError('List<String>', key, list);
  }

  return List<String>.from(list);
}

List<T>? expectNullableListOf<T>(
  Map<String, dynamic> json,
  String key,
  T Function(dynamic raw) convert,
) {
  final v = json[key];
  if (v == null) return null;

  if (v is! List) throwTypeError('List<$T>', key, v);

  return v.map((e) => convert(e)).toList();
}

T? expectNullableEnumByName<T extends Enum>(
  Map<String, dynamic> json,
  String key,
  List<T> values,
) {
  final raw = json[key];
  if (raw == null) return null;

  if (raw is! String) throwTypeError('Enum name (String)', key, raw);

  try {
    return values.firstWhere((e) => e.name == raw);
  } catch (_) {
    throw FormatException(
      "Invalid enum value '$raw' for '$key'. Expected one of: "
      "${values.map((e) => e.name).join(', ')}.",
    );
  }
}

DateTime? expectNullableDateTime(
  Map<String, dynamic> json,
  String key,
) {
  final raw = json[key];
  if (raw == null) return null;

  if (raw is! String) {
    throwTypeError('ISO-8601 DateTime String', key, raw);
  }

  try {
    return DateTime.parse(raw);
  } catch (_) {
    throw FormatException(
      "Invalid DateTime format for '$key': '$raw'",
    );
  }
}
