import 'package:flutter/material.dart';

import 'base_button.dart';
import 'base_button_state.dart';

class AppOutlinedButton extends BaseButton {
  const AppOutlinedButton({
    super.key,
    super.height,
    super.fontSize,
    super.iconSize,
    super.radius,
    super.width,
    super.padding,
    super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.textColor,
    super.focusNode,
    super.borderRadius,
    super.borderSide,
    super.autofocus,
    super.iconInRight,
    super.disabled,
    super.statesController,
    super.showLoading,
    super.child,
    super.icon,
    required super.label,
    super.foregroundColor,
    super.fontWeight,
    super.listenEnter,
    super.requireVisibleToActivate,
    super.tooltip,
    super.lockSizeWhileLoading,
  });

  @override
  State<AppOutlinedButton> createState() => _AppOutlinedButtonState();
}

class _AppOutlinedButtonState extends BaseButtonState<AppOutlinedButton> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fg = widget.textColor ?? widget.foregroundColor ?? theme.colorScheme.primary;

    final button = OutlinedButton(
      onPressed: isDisabled ? null : onTap,
      onLongPress: isDisabled ? null : onLongPress,
      onFocusChange: widget.onFocusChange,
      autofocus: widget.autofocus,
      focusNode: focusNode,
      statesController: widget.statesController,
      onHover: widget.onHover,
      style: widget.style,
      clipBehavior: Clip.antiAlias,
      child: buildContent(context, fg: fg),
    );

    return buildButtonWrapper(context, button: button);
  }
}
