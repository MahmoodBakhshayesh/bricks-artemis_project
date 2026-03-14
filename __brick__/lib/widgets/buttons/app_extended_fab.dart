import 'package:flutter/material.dart';
import '../../core/extensions/context_extension.dart';
import 'base_button.dart';
import 'base_button_state.dart';

/// A custom Floating Action Button that extends [BaseButton] to provide
/// consistent behavior and state management (e.g., loading states) across the app.
class AppExtendedFab extends BaseButton {
  const AppExtendedFab({
    super.key,
    required super.label,
    super.onPressed,
    super.icon,
    super.disabled = false,
    super.showLoading = true,
    super.tooltip,
    super.height = 56.0, // Default FAB height
    super.fontSize,
    super.iconSize,
    super.focusNode,
    super.autofocus = false,
    super.foregroundColor,
    super.textColor,
  });

  @override
  State<AppExtendedFab> createState() => _AppExtendedFabState();
}

class _AppExtendedFabState extends BaseButtonState<AppExtendedFab> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: isDisabled ? null : onTap,
      label: buildContent(context, fg: context.theme.colorScheme.onPrimaryContainer),
      tooltip: widget.tooltip,
      focusNode: focusNode,
      autofocus: widget.autofocus,
    );
  }

  /// Overriding the button wrapper for FAB.
  ///
  /// A Floating Action Button's size and position are managed by the Scaffold's
  /// `floatingActionButton` property, so we don't wrap it in a `SizedBox`
  /// or `ConstrainedBox` like other buttons.
  @override
  Widget buildButtonWrapper(BuildContext context, {required Widget button}) {
    // The focus and tooltip handling are not needed here as they are
    // passed directly to the FloatingActionButton.extended widget itself.
    return button;
  }
}
