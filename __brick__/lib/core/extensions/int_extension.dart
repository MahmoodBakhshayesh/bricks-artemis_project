extension IntUtils on int? {
  String? get withTwoNumberFormat {
    final value = this;
    if (value == null) return null;

    if (value < 10) return '0$value';
    return '$value';
  }
}
