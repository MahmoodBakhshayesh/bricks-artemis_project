import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../core/extensions/context_extension.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.size = 50.0, this.color});

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SpinKitCircle(
      color: color ?? context.theme.colorScheme.primary,
      size: size,
    );
  }
}
