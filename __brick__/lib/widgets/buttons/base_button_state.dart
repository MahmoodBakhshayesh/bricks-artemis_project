import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'base_button.dart';

abstract class BaseButtonState<T extends BaseButton> extends State<T> {
  bool loading = false;
  bool isVisible = true;
  late final FocusNode internalFocusNode;
  final GlobalKey contentKey = GlobalKey();
  double? stableContentWidth;

  FocusNode get focusNode => widget.focusNode ?? internalFocusNode;

  bool get isLoading => (loading || widget.forceLoading);

  bool get isDisabled => widget.disabled || (widget.onPressed == null && widget.onLongPress == null) || isLoading;

  @override
  void didUpdateWidget(covariant T oldWidget) {
    if (oldWidget.forceLoading != widget.forceLoading) setState(() {});
    super.didUpdateWidget(oldWidget);
  }

  Future<void> trigger({AsyncOrSyncVoidCallback? action}) async {
    if (isDisabled) return;
    if (widget.requireVisibleToActivate && !isVisible) return;
    final cb = action ?? widget.onPressed;
    if (cb == null) return;

    final r = cb();
    if (r is Future) {
      if (isLoading) return;
      startLoading();
      try {
        await r;
      } finally {
        if (mounted) stopLoading();
      }
    }
  }

  void startLoading() {
    if (!isLoading && mounted) setState(() => loading = true);
  }

  void stopLoading() {
    if (isLoading && mounted) setState(() => loading = false);
  }

  void setVisibility(bool v) {
    if (mounted && isVisible != v) setState(() => isVisible = v);
  }

  @override
  void initState() {
    super.initState();
    internalFocusNode = FocusNode(debugLabel: 'BaseButtonFN');
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      internalFocusNode.dispose();
    }
    super.dispose();
  }

  Future<void> onTap() => trigger();

  Future<void> onLongPress() async {
    final cb = widget.onLongPress;
    if (cb == null) return;
    final r = cb();
    if (r is Future) {
      if (isLoading) return;
      startLoading();
      try {
        await r;
      } finally {
        if (mounted) stopLoading();
      }
    }
  }

  Future<void> measureContentWidthAfterBuild() async {
    if (!mounted || !widget.lockSizeWhileLoading) return;

    final context = contentKey.currentContext;
    if (context == null) return;

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) return;

    final newW = renderBox.size.width;
    if (stableContentWidth == null || (newW - stableContentWidth!).abs() > 0.5) {
      // Post frame callback to avoid calling setState during build.
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() => stableContentWidth = newW);
        }
      });
    }
  }

  Widget buildContent(BuildContext context, {required Color fg}) {
    final normalContent = Padding(
      key: widget.lockSizeWhileLoading ? contentKey : null,
      padding: const EdgeInsets.all(2.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!widget.iconInRight && widget.icon != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Icon(widget.icon, color: fg, size: widget.iconSize),
            ),
          widget.child != null
              ? Flexible(child: widget.child!)
              : Text(
                  widget.label,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: widget.fontSize, fontWeight: widget.fontWeight),
                ),
          if (widget.iconInRight && widget.icon != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Icon(widget.icon, size: widget.iconSize),
            ),
        ],
      ),
    );

    if (!isLoading) {
      // We still need to schedule the measurement after the build.
      SchedulerBinding.instance.addPostFrameCallback((_) => measureContentWidthAfterBuild());
    }

    final loadingContent = SizedBox(
      width: widget.lockSizeWhileLoading ? stableContentWidth : null,
      height: widget.iconSize,
      child: Center(
        child: SpinKitThreeBounce(color: fg, size: (widget.iconSize ?? 18)),
      ),
    );

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 150),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      layoutBuilder: (currentChild, previousChildren) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        );
      },
      child: isLoading && widget.showLoading ? Container(child: loadingContent) : Container(child: normalContent),
    );
  }

  Widget buildButtonWrapper(BuildContext context, {required Widget button}) {
    Widget wrappedButton = ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: widget.height,
        maxHeight: widget.height,
      ),
      child: SizedBox(
        width: widget.width,
        child: button,
      ),
    );

    if (widget.tooltip?.isNotEmpty == true) {
      wrappedButton = Tooltip(message: widget.tooltip!, child: wrappedButton);
    }

    if (!widget.listenEnter) return wrappedButton;

    return Focus(
      focusNode: focusNode,
      autofocus: widget.autofocus,
      canRequestFocus: true,
      child: Shortcuts(
        shortcuts: const {
          SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
          SingleActivator(LogicalKeyboardKey.numpadEnter): ActivateIntent(),
        },
        child: Actions(
          actions: {
            ActivateIntent: CallbackAction<ActivateIntent>(
              onInvoke: (intent) {
                if (!Focus.of(context).hasFocus) return null;
                if (widget.requireVisibleToActivate && !isVisible) return null;
                onTap();
                return null;
              },
            ),
          },
          child: wrappedButton,
        ),
      ),
    );
  }
}
