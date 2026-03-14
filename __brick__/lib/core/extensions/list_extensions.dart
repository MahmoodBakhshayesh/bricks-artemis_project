
extension StringListUtils on List<String> {
  int get validFieldsLength {
    int count = 0;

    for (final item in this) {
      if (item.isNotEmpty) count++;
    }

    return count;
  }

  void fillUntilIndex(int index) {
    while (length <= index) {
      add('');
    }
  }
}
