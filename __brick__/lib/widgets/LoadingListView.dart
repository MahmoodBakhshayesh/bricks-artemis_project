
import 'package:flutter/material.dart';
import '../core/interface_implementations/spiners.dart';

class LoadingListView extends StatelessWidget {
  final bool loading;
  final Widget child;
  const LoadingListView({Key? key, required this.loading, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return loading ? Spinners.spinner1 : child;
  }
}
