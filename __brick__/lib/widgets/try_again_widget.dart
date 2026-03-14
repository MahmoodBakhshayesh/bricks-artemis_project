import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../core/extensions/context_extension.dart';
import '../core/interfaces/base_result.dart';
import 'buttons/app_outlined_button.dart';

class TryAgainWidget extends StatelessWidget {
  const TryAgainWidget({super.key, this.onTryAgain, this.error});

  final AsyncCallback? onTryAgain;
  final Failure? error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8,
        children: [
          Text(
            error?.message ?? context.localizations.error,
            textAlign: .center,
          ),
          if (onTryAgain != null) AppOutlinedButton(label: context.localizations.tryAgain, onPressed: onTryAgain),
        ],
      ),
    );
  }
}
