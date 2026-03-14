import 'dart:async';
import 'package:flutter/widgets.dart';
import '../core/helpers/failure_presenter.dart';
import '../core/interfaces/base_failure.dart';

class GlobalFailureListener extends StatefulWidget {
  final Widget child;

  const GlobalFailureListener({super.key, required this.child});

  @override
  State<GlobalFailureListener> createState() => _GlobalFailureListenerState();
}

class _GlobalFailureListenerState extends State<GlobalFailureListener> {
  StreamSubscription<FailureNotice>? _sub;

  @override
  void initState() {
    super.initState();
    _sub = FailureBus.I.stream.listen(FailurePresenter.show, onError: (_) {});
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
