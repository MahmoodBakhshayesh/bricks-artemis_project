import 'package:flutter/material.dart';

class MyAnimatedSwitcher extends StatelessWidget {
  final bool value;
  final Widget firstChild;
  final Widget secondChild;
  final Axis direction;
  final double axisAlignment;

  const MyAnimatedSwitcher({
    Key? key,
    required this.value,
    required this.firstChild,
    required this.secondChild,
    this.direction = Axis.vertical,
    this.axisAlignment = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (child, animation) => SizeTransition(axis: direction, axisAlignment: axisAlignment, sizeFactor: animation, child: child),
      child: value ? firstChild : secondChild,
    );
  }
}
