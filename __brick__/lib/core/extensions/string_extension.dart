import 'package:intl/intl.dart' as intl;

extension StringExt on String {
  bool get isValidIp => ipv4RegExp.hasMatch(this);

  bool get isValidIpPort => ipv4portRegExp.hasMatch(this);

  String get capitalizeFirstLetter => '${this[0].toUpperCase()}${substring(1)}';

  String get convertRouteNameForBreadCrumbs =>
      replaceAll('-', ' ').replaceAll('_', ' ').split(' ').map((e) => e.capitalizeFirstLetter).join(' ');

  /// example: 25Mar, Mon
  String get convertDateTimeStringToddMMME {
    final dateTime = DateTime.tryParse(this);
    if (dateTime != null) {
      return intl.DateFormat('ddMMM, E').format(dateTime);
    }
    return this;
  }

  /// example: 25Mar
  String get convertDateTimeStringToddMMM {
    final dateTime = DateTime.tryParse(this);
    if (dateTime != null) {
      return intl.DateFormat('dd MMM').format(dateTime);
    }
    return this;
  }

  /// example: 25Mar 23:10:55
  String get convertDateTimeStringToddMMMHMS {
    final dateTime = DateTime.tryParse(this);
    if (dateTime != null) {
      return intl.DateFormat('dd MMM - HH:mm:ss').format(dateTime);
    }
    return this;
  }

  /// example: 23:10:55
  String get convertDateTimeStringToHMS {
    final dateTime = DateTime.tryParse(this);
    if (dateTime != null) {
      return intl.DateFormat('HH:mm:ss').format(dateTime);
    }
    return this;
  }
}

extension StringNullExt on String? {
  String? get pureValue => this == null
      ? null
      : this!.isEmpty
      ? null
      : this;

  DateTime? get parseDateQ {
    if (this == null) return null;

    final p = this!.split('-');
    if (p.length != 3) return null;
    try {
      return DateTime(int.parse(p[0]), int.parse(p[1]), int.parse(p[2]));
    } catch (_) {
      return null;
    }
  }
}

final RegExp boardingPassRegex = RegExp(r'^M1[\w\s]{20}[\w\s]{8}[\w\s]{3}[\w\s]{3}[\w\s]{3}\d{4}\s\d{3}\w{1}[\w\s]{3}\d\s{3}$');

RegExp ipv4RegExp = RegExp(r'^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$');
// RegExp ipv4portRegExp = RegExp(r'^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$',);
final ipv4portRegExp = RegExp(r'^((25[0-5]|2[0-4][0-9]|[0-1]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[0-1]?[0-9][0-9]?):([0-9]{1,5})$');

RegExp validSeatReg = RegExp(r'^\d{1,3}[A-Za-z]');
