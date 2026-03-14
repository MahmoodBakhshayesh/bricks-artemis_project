import 'package:flutter/material.dart';

import 'base_button.dart';
import 'base_button_state.dart';

class SubmitButton extends BaseButton {
  final bool fade;
  final bool flat;
  final bool reverse;

  const SubmitButton({
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
    this.fade = false,
    this.flat = false,
    this.reverse = false,
    super.backgroundColor,
    super.foregroundColor,
    super.disabledForegroundColor,
    super.disabledBackgroundColor,
    super.fontWeight,
    super.listenEnter,
    super.requireVisibleToActivate,
    super.tooltip,
    super.lockSizeWhileLoading,
    super.forceLoading,
  });

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends BaseButtonState<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final Color main = widget.foregroundColor ?? cs.primary;
    final bool reversed = widget.reverse;

    Color fg = reversed ? main : cs.onPrimary;

    if (widget.textColor != null) {
      fg = widget.textColor!;
    } else if (widget.fade && !reversed) {
      fg = main;
    }

    Color? borderColor = widget.borderSide?.color ?? (reversed ? main : null);

    if (isDisabled) {
      fg = theme.disabledColor;
      borderColor ??= theme.disabledColor;
    }

    final button = FilledButton(
      style: FilledButton.styleFrom(
        shape: widget.borderRadius == null ? null : RoundedRectangleBorder(borderRadius: widget.borderRadius!),
        padding: widget.padding,
        backgroundColor: widget.backgroundColor,
        foregroundColor: widget.foregroundColor,
        disabledForegroundColor: widget.disabledForegroundColor,
        disabledBackgroundColor: widget.disabledBackgroundColor,
        // minimumSize: Size(40, 20),
        // fixedSize: Size(40, 20)
      ),
      onPressed: isDisabled ? null : onTap,
      onLongPress: isDisabled ? null : onLongPress,
      onFocusChange: widget.onFocusChange,
      autofocus: widget.autofocus,
      focusNode: focusNode,
      statesController: widget.statesController,
      onHover: widget.onHover,
      clipBehavior: Clip.antiAlias,
      child: buildContent(context, fg: fg),
    );

    return buildButtonWrapper(context, button: button);
  }
}
