import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CallbackShortcuts extends StatelessWidget {
  const CallbackShortcuts({
    Key? key,
    required this.bindings,
    required this.child,
  }) : super(key: key);

  final Map<ShortcutActivator, VoidCallback> bindings;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onKey: (node, event) {
        KeyEventResult result = KeyEventResult.ignored;
        // Activates all key bindings that match, returns handled if any handle it.
        for (final ShortcutActivator activator in bindings.keys) {
          if (activator.accepts(event, RawKeyboard.instance)) {
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
  KeyEventResult handleKeypress(BuildContext context, RawKeyEvent event) {
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
    // print('Action invoked: $action($intent) from $context');
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
    LogicalKeySet(LogicalKeyboardKey.escape): const ESCIntent(),
  };
}





class SelectAllIntent extends Intent {
  const SelectAllIntent();
}

class ESCIntent extends Intent {
  const ESCIntent();
}


