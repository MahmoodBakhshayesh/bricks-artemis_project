import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../initialize.dart';


class CallbackShortcuts extends StatelessWidget {
  const CallbackShortcuts({
    super.key,
    required this.bindings,
    required this.child,
  });

  final Map<ShortcutActivator, VoidCallback> bindings;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onKeyEvent: (node, event) {
        KeyEventResult result = KeyEventResult.ignored;
        // Activates all key bindings that match, returns handled if any handle it.
        for (final ShortcutActivator activator in bindings.keys) {
          if (activator.accepts(event, HardwareKeyboard.instance)) {
            bindings[activator]!.call();
            result = KeyEventResult.handled;
          }
        }
        return result;
      },
      child: child,
    );
  }
}

class LoggingShortcutManager extends ShortcutManager {
  @override
  KeyEventResult handleKeypress(BuildContext context, KeyEvent event) {
    final KeyEventResult result = super.handleKeypress(context, event);
    if (result == KeyEventResult.handled) {
      log('Handled shortcut $event in $context');
    }

    return result;
  }
}

class LoggingActionDispatcher extends ActionDispatcher {
  @override
  Object? invokeAction(
      covariant Action<Intent> action,
      covariant Intent intent, [
        BuildContext? context,
      ]) {
    final WidgetRef ref = getIt<WidgetRef>();

    log('Action invoked: $action($intent) ');
    super.invokeAction(action, intent, context);


    return null;
  }
}

class AppShortcuts {
  AppShortcuts._();

  static Map<ShortcutActivator, Intent> shortcuts = <ShortcutActivator, Intent>{
    // ...WidgetsApp.defaultShortcuts,
    LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyA): const SelectAllIntent(),
    LogicalKeySet(LogicalKeyboardKey.arrowDown): const ESCIntent(),
    LogicalKeySet(LogicalKeyboardKey.enter): const ENTIntent(),
    LogicalKeySet(LogicalKeyboardKey.tab): const TABIntent(),
    LogicalKeySet(LogicalKeyboardKey.arrowDown): const ArrowDownIntent(),
    LogicalKeySet(LogicalKeyboardKey.space): const SpaceIntent(),
    LogicalKeySet(LogicalKeyboardKey.alphanumeric): const AlphanumericIntent(),
  };
}

class SelectAllIntent extends Intent {
  const SelectAllIntent();
}

class ESCIntent extends Intent {
  const ESCIntent();
}

class ENTIntent extends Intent {
  const ENTIntent();
}

class TABIntent extends Intent {
  const TABIntent();
}

class ArrowDownIntent extends Intent {
  const ArrowDownIntent();
}


class ArrowUpIntent extends Intent {
  const ArrowUpIntent();
}

class SpaceIntent extends Intent {
  const SpaceIntent();
}

class AlphanumericIntent extends Intent {
  const AlphanumericIntent();
}
