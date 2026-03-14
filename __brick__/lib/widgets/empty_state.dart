import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.content, this.svgPath, this.foregroundColor});

  final String content;
  final String? svgPath;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 250),
        child: Column(
          mainAxisSize: .min,
          spacing: 8,
          children: [
            if (svgPath != null)
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 150),
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child:Text("SVG")
                  ),
                ),
              ),
            Text(
              content,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: foregroundColor ?? const Color(0xffC5C5C5)),
            ),
          ],
        ),
      ),
    );
  }
}
