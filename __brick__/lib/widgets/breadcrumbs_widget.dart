import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/extensions/context_extension.dart';
import '../core/extensions/string_extension.dart';

class BreadcrumbsWidget extends StatelessWidget {
  const BreadcrumbsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: GoRouter.of(context).routeInformationProvider,
      builder: (context, child) {
        final currentFullPath = context.currentPath;
        final segments = currentFullPath.split('/').where((s) => s.isNotEmpty).toList();

        return Padding(
          padding: const .all(8.0),
          child: Wrap(
            spacing: 8,
            crossAxisAlignment: .center,
            children: [
              if (segments.isNotEmpty) ...[
                const RotatedBox(
                  quarterTurns: 1,
                  child: Icon(Icons.flight_outlined, size: 20),
                ),
                Text(
                  segments.first.convertRouteNameForBreadCrumbs,
                  style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                ),
              ],
              for (int i = 1; i < segments.length; i++) ...[
                const Icon(Icons.arrow_forward_ios_outlined, size: 12),
                Text(
                  segments[i].convertRouteNameForBreadCrumbs,
                  style: context.textTheme.bodyLarge?.copyWith(color: context.theme.hintColor),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
