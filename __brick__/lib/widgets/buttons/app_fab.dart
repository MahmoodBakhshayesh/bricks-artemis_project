import 'package:flutter/material.dart';
import '../../core/extensions/context_extension.dart';
import 'base_button.dart';
import 'base_button_state.dart';

/// A custom Floating Action Button that extends [BaseButton] to provide
/// consistent behavior and state management (e.g., loading states) across the app.
class AppFab extends BaseButton {
  const AppFab({
    super.key,
    required super.icon,
    super.onPressed,
    super.disabled = false,
    super.showLoading = true,
    super.tooltip,
    super.height = 56.0, // Default FAB height
    super.iconSize,
    super.focusNode,
    super.autofocus = false,
    super.backgroundColor,
    super.foregroundColor,
  }) : super(label: '');

  @override
  State<AppFab> createState() => _AppFabState();
}

class _AppFabState extends BaseButtonState<AppFab> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: isDisabled ? null : onTap,
      tooltip: widget.tooltip,
      focusNode: focusNode,
      autofocus: widget.autofocus,
      backgroundColor: widget.backgroundColor,
      child: buildContent(context, fg: context.theme.colorScheme.onPrimary),
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
    // passed directly to the FloatingActionButton widget itself.
    return button;
  }
}
