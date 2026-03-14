import 'package:flutter/material.dart';
import '../../core/extensions/context_extension.dart';
import 'hoverable_tab_bar_item.dart';
import 'hoverable_tab_bar_overlay_entry.dart';

class HoverableTabBar extends StatefulWidget {
  const HoverableTabBar({super.key, this.menuList = const [], required this.title, this.onPressed, this.routePrefix})
    : value = '',
      icon = null;

  const HoverableTabBar.single({super.key, required this.title, required this.value, this.onPressed, this.icon})
    : menuList = const [],
      routePrefix = null;

  final String title;
  final String value;
  final String? routePrefix;
  final List<HoverableTabBarItem> menuList;
  final ValueChanged<String>? onPressed;
  final IconData? icon;

  @override
  State<HoverableTabBar> createState() => _HoverableTabBarState();
}

class _HoverableTabBarState extends State<HoverableTabBar> with TickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool _isMouseOnOverlay = false;
  bool _isMouseOnTabBar = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;
    _animationController.forward();
    _overlayEntry = createHoverableTabBarOverlayEntry(
      context: context,
      layerLink: _layerLink,
      menuList: widget.menuList,
      animation: _animation,
      onEnter: () => setState(() => _isMouseOnOverlay = true),
      onExit: () {
        setState(() => _isMouseOnOverlay = false);
        _hideOverlay();
      },
      onPressed: (value) {
        widget.onPressed?.call(value);
        _animationController.reverse().then((value) {
          _overlayEntry?.remove();
          _overlayEntry = null;
          setState(() {
            _isMouseOnOverlay = false;
            _isMouseOnTabBar = false;
          });
        });
      },
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    Future.delayed(const Duration(milliseconds: 50), () {
      if (!_isMouseOnOverlay && !_isMouseOnTabBar && _overlayEntry != null) {
        _animationController.reverse().then((value) {
          _overlayEntry?.remove();
          _overlayEntry = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isInRoutePrefix = widget.routePrefix != null && context.fullPath.startsWith(widget.routePrefix!);

    if (widget.menuList.isEmpty) {
      return Material(
        color: context.theme.colorScheme.secondaryFixed,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
        child: InkWell(
          onTap: () => widget.onPressed?.call(widget.value),
          canRequestFocus: false,
          hoverDuration: const Duration(milliseconds: 200),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
          hoverColor: context.theme.colorScheme.secondaryFixedDim,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Row(
              mainAxisSize: .min,
              spacing: 4,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(color: context.theme.colorScheme.onSecondaryFixed),
                ),
                if (widget.icon != null) Icon(widget.icon!, size: 18),
              ],
            ),
          ),
        ),
      );
    }

    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) {
          setState(() => _isMouseOnTabBar = true);
          _showOverlay();
        },
        onExit: (_) {
          setState(() => _isMouseOnTabBar = false);
          _hideOverlay();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            color: (_isMouseOnTabBar || _isMouseOnOverlay)
                ? context.theme.colorScheme.secondaryFixedDim
                : isInRoutePrefix
                ? context.theme.colorScheme.surfaceDim
                : context.theme.colorScheme.secondaryFixed,
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Text(
            widget.title,
            style: TextStyle(color: context.theme.colorScheme.onSecondaryFixed),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }
}
