import 'package:flutter/material.dart';

/// A custom expansion tile widget built from scratch without using
/// Flutter's ExpansionTile or ExpansionPanelList.
///
/// It features a header with a title and a rotating arrow icon, and a
/// collapsible body that animates its visibility.
class CustomExpansionTile extends StatefulWidget {
  /// The primary content of the header. Typically a [Text] widget.
  final Widget? title;

  /// The widget to display in the collapsible body.
  final Widget? expandedBody;

  /// The padding around the children.
  final EdgeInsetsGeometry? childrenPadding;

  /// The padding around the header content.
  final EdgeInsetsGeometry? headerPadding;

  /// The background color of the header.
  final Color? headerBackgroundColor;

  /// The color to be used for the icon in the header.
  final Color? iconColor;

  /// An optional widget to display before the expand/collapse arrow.
  final Widget? trailing;

  /// The border radius for the header.
  final BorderRadius? borderRadius;

  /// Whether the tile is initially expanded. Defaults to `false`.
  final bool initiallyExpanded;

  const CustomExpansionTile({
    super.key,
    this.title,
    this.expandedBody,
    this.childrenPadding,
    this.headerPadding,
    this.headerBackgroundColor,
    this.iconColor,
    this.trailing,
    this.borderRadius,
    this.initiallyExpanded = false,
  });

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;

    // Initialize the AnimationController.
    // The vsync is required for the animation to run.
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    // Animation for the arrow icon rotation.
    // It rotates 180 degrees (0.5 turns).
    _iconTurns = Tween<double>(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Animation for the body's height.
    _heightFactor = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    // If initially expanded, play the animation forward.
    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    // Always dispose of the controller to free up resources.
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        // Play animation forward to expand.
        _controller.forward();
      } else {
        // Play animation in reverse to collapse.
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // The Header
        Material(
          color: widget.headerBackgroundColor,
          borderRadius: widget.borderRadius,
          child: InkWell(
            onTap: _toggleExpansion,
            borderRadius: widget.borderRadius,
            child: Padding(
              padding: widget.headerPadding ?? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // The Title
                  if (widget.title != null)
                    Expanded(
                      child: widget.title!,
                    ),
                  // The optional trailing widget and the animated arrow icon
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.trailing != null) ...[widget.trailing!, const SizedBox(width: 8)],
                      RotationTransition(
                        turns: _iconTurns,
                        child: Icon(
                          Icons.expand_more,
                          color: widget.iconColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        // The Collapsible Body
        ClipRect(
          child: SizeTransition(
            sizeFactor: _heightFactor,
            axisAlignment: -1.0,
            child: Padding(
              padding: widget.childrenPadding ?? EdgeInsets.zero,
              child: widget.expandedBody ?? const SizedBox.shrink(),
            ),
          ),
        ),
      ],
    );
  }
}
