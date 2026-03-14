import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../buttons/app_icon_button.dart';

class ParentBottomSheetBuilder extends StatelessWidget {
  const ParentBottomSheetBuilder({
    super.key,
    required this.title,
    this.svgPath,
    this.showCloseButton = true,
    required this.body,
    this.constraints,
    this.svgColor,
  });

  final String title;
  final String? svgPath;
  final Color? svgColor;
  final bool showCloseButton;
  final Widget body;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: constraints ?? const BoxConstraints(),
      child: Column(
        mainAxisSize: .min,
        children: [
          _headerSection(context),
          Flexible(child: SafeArea(child: body)),
        ],
      ),
    );
  }

  Widget _headerSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppTheme.dialogBorderRadius.topLeft.y)),
        border: const Border(bottom: BorderSide(color: Color(0xffD3D3D3))),
        color: const Color(0xffEAF1FF),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Row(
            mainAxisSize: .min,
            spacing: 10,
            crossAxisAlignment: .center,
            children: [

              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xff343330)),
                maxLines: 1,
              ),
            ],
          ),
          if (showCloseButton)
            AppIconButton(
              onPressed: Navigator.of(context, rootNavigator: true).pop,
              iconSize: 26,
              foregroundColor: Colors.black,
              icon: Icons.close,
            ),
        ],
      ),
    );
  }
}
