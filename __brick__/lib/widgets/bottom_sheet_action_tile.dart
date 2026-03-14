import 'package:flutter/material.dart';

class BottomSheetActionTile extends StatelessWidget {
  const BottomSheetActionTile({super.key, required this.title, this.svgPath, this.icon, this.onPressed, this.iconColor, this.titleStyle, this.titleColor});

  final String title;
  final String? svgPath;
  final IconData? icon;
  final Color? iconColor;
  final Color? titleColor;
  final VoidCallback? onPressed;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;

    return ListTile(
      onTap: onPressed,
      titleAlignment: .center,
      shape: const Border(bottom: BorderSide(color: Color(0xffD8D8D8))),
      minVerticalPadding: 20,
      title: Row(
        mainAxisAlignment: .center,
        spacing: 8,
        children: [

          if (icon != null)
            Icon(
              icon,
              color: iconColor ?? (isEnabled ? const Color(0xff343330) : const Color(0xffB3B3B3)),
              size: 20,
            ),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isEnabled ? (titleColor ?? const Color(0xff343330)) : const Color(0xffB3B3B3),
            ).merge(titleStyle),
          ),
        ],
      ),
    );
  }
}
