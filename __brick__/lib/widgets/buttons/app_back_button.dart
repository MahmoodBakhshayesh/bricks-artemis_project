import 'package:flutter/material.dart';
import '../../core/extensions/context_extension.dart';
import '../../core/interfaces/base_navigation_service.dart';
import '../../di.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  void onBackButtonPressed() => locator<BaseNavigationService>().pop();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ?? onBackButtonPressed,
      tooltip: context.localizations.back,
      icon: const Icon(Icons.arrow_back_ios_new_outlined),
    );
  }
}
