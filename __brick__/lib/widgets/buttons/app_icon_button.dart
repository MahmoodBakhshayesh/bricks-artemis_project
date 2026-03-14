import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'base_button.dart';
import 'base_button_state.dart';

class AppIconButton extends BaseButton {
  const AppIconButton({
    super.key,
    super.width,
    super.height,
    super.iconSize,
    super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.textColor,
    super.focusNode,
    super.autofocus,
    super.disabled,
    super.statesController,
    super.showLoading,
    super.icon,
    super.child,
    super.foregroundColor,
    super.requireVisibleToActivate,
    super.tooltip,
    super.forceLoading,
  }) : assert(onLongPress == null, 'IconButton does not support onLongPress'),
       assert(
         (child == null) != (icon == null),
         'Exactly one of child or icon must be provided.',
       ),
       super(label: '');

  @override
  State<AppIconButton> createState() => _AppIconButtonState();
}

class _AppIconButtonState extends BaseButtonState<AppIconButton> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fg = widget.textColor ?? widget.foregroundColor ?? theme.colorScheme.primary;

    final normalContent = widget.child ?? Icon(widget.icon, size: widget.iconSize, color: fg);

    final loadingContent = SizedBox(
      width: widget.lockSizeWhileLoading ? stableContentWidth : null,
      height: widget.iconSize,
      child: Center(
        child: SpinKitThreeBounce(color: fg, size: (widget.iconSize ?? 18) * 0.7),
      ),
    );

    Widget content = AnimatedSwitcher(
      duration: const Duration(milliseconds: 150),
      child: (loading && widget.showLoading) ? Container(child: loadingContent) : Container(child: normalContent),
    );

    return SizedBox(
      width: widget.height,
      height: widget.height,
      child: IconButton(
        onPressed: isDisabled ? null : onTap,
        focusNode: focusNode,
        autofocus: widget.autofocus,
        statesController: widget.statesController,
        onHover: widget.onHover,
        style: widget.style,
        tooltip: widget.tooltip,
        icon: content,
      ),
    );
  }
}
