import 'package:flutter/material.dart';
import '../buttons/app_text_button.dart';
import 'hoverable_tab_bar_item.dart';

OverlayEntry createHoverableTabBarOverlayEntry({
  required BuildContext context,
  required LayerLink layerLink,
  required List<HoverableTabBarItem> menuList,
  required Animation<double> animation,
  required VoidCallback onEnter,
  required VoidCallback onExit,
  ValueChanged<String>? onPressed,
}) {
  return OverlayEntry(
    builder: (context) {
      return PositionedDirectional(
        top: 0,
        start: 0,
        child: CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          targetAnchor: .bottomLeft,
          child: FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation,
              alignment: .topLeft,
              child: Material(
                elevation: 4.0,
                borderRadius: BorderRadius.circular(6),
                clipBehavior: .hardEdge,
                child: MouseRegion(
                  onEnter: (_) => onEnter(),
                  onExit: (_) => onExit(),
                  child: IntrinsicWidth(
                    child: Column(
                      mainAxisSize: .min,
                      crossAxisAlignment: .stretch,
                      children: menuList.map((item) {
                        return AppTextButton(
                          style: TextButton.styleFrom(
                            shape: const RoundedRectangleBorder(),
                            alignment: AlignmentDirectional.centerStart,
                          ),
                          onPressed: () => onPressed?.call(item.value),
                          label: item.title,
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
