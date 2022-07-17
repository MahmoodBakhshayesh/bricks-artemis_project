import 'package:flutter/material.dart';

class MyAnimatedSwitcher extends StatelessWidget {
  final bool value;
  final Widget firstChild;
  final Widget secondChild;
  const MyAnimatedSwitcher({Key? key,required this.value, required this.firstChild,required this.secondChild}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (child, animation) => SizeTransition(axisAlignment: 1.0, sizeFactor: animation, child: child),
      child: value
          ? firstChild
          : secondChild,
    );
  }
}
