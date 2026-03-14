import 'package:flutter/material.dart';
import '../../core/extensions/context_extension.dart';
import '../../core/interfaces/base_overlays_helper.dart';
import '../../di.dart';

class TokenExpireOverlay extends StatelessWidget {
  const TokenExpireOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return  Dialog(
      key: locator<BaseOverlaysHelper>().alertKey,
      constraints: const BoxConstraints(maxWidth: 600),
      child: Padding(
        padding: const .all(24),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text('${context.localizations.tokenExpired}!', style: context.textTheme.headlineSmall),
                // IconButton(
                //   onPressed: Navigator.of(context, rootNavigator: true).pop,
                //   tooltip: context.localizations.close,
                //   style: IconButton.styleFrom(foregroundColor: context.theme.colorScheme.error),
                //   icon: const Icon(Icons.close),
                // ),
              ],
            ),
            const SizedBox(height: 18),
            const Divider(height: 1),
            const SizedBox(height: 18),
            const SizedBox(height: 18),
            // const SizedBox(height: 12),
            // const RememberMeLoginWidget(),
            const SizedBox(height: 54),
            const Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Text("login again")
            ),
          ],
        ),
      ),
    );
  }
}
