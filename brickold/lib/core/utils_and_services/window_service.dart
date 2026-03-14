import 'dart:collection';

Window window = Window();

class Window {
  late Storage sessionStorage;

  void open(String url, String name, [String? options]) {}
}

class Storage with MapMixin<String, String> {
  @override
  String? operator [](Object? key) {
    throw UnimplementedError();
  }

  @override
  void operator []=(String key, String value) {}

  @override
  void clear() {}

  @override
  Iterable<String> get keys => throw UnimplementedError();

  @override
  String? remove(Object? key) {
    throw UnimplementedError();
  }
}

class Blob {
  Blob(List<List<int>> list);
}

class Url {
  static createObjectUrlFromBlob(Blob blob) {}

  static void revokeObjectUrl(url) {}
}

class document {
  static var body;

  static var cookie;

  static createElement(String s) {}
}

class AnchorElement {
  var href;
  var style;
  late String download;

  late String target;

  AnchorElement({href});

  void click() {}

  void remove() {}
}
