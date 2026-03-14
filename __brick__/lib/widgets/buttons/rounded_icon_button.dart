import 'package:flutter/material.dart';

import 'app_icon_button.dart';

class RoundedIconButton extends StatelessWidget {
  const RoundedIconButton({
    super.key,
    required this.onPressed,
    this.foregroundColor = const Color(0xff16305A),
    this.backgroundColor = Colors.white,
    this.size = const Size(40, 40),
    required this.child,
    this.padding,
    this.tooltip,
    this.borderSide,
    this.showLoading = true,
    this.forceLoading = false,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final Color foregroundColor;
  final Color backgroundColor;
  final Size size;
  final EdgeInsets? padding;
  final String? tooltip;
  final BorderSide? borderSide;
  final bool showLoading;
  final bool forceLoading;

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      width: size.width,
      height: size.height,
      showLoading: showLoading,
      forceLoading: forceLoading,
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: .circular(8), side: borderSide ?? BorderSide.none),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        disabledBackgroundColor: backgroundColor.withValues(alpha: 0.5),
        disabledForegroundColor: foregroundColor.withValues(alpha: 0.5),
        padding: padding,
      ),
      child: child,
    );
  }
}
