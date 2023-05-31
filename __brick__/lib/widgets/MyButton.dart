import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class MyButton extends StatefulWidget {
  final double height;
  final double? width;
  final Callback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool autofocus;
  final MaterialStatesController? statesController;
  final Widget? child;
  final String label;
  final bool showLoading;
  final bool fade;
  final Color? color;

  const MyButton(
      {super.key,
      this.height = 35,
      this.width,
      this.onPressed,
      this.onLongPress,
      this.onHover,
      this.onFocusChange,
      this.style,
      this.focusNode,
      this.autofocus = false,
      this.statesController,
      this.showLoading = true,
      this.child,
      required this.label,
      // this.loading = false,
      this.fade = false,
      this.color});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool _loading = false;

  _onTap() {
    if (widget.onPressed is AsyncCallback) {
      if (_loading) return;
      _loading = true;
      setState(() {});
      (widget.onPressed as AsyncCallback).call().whenComplete(() {
        _loading = false;
        setState(() {});
      });
    } else {
      widget.onPressed?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color c = widget.color ?? theme.primaryColor;
    return ElevatedButton(
      onPressed: _onTap,
      onLongPress: widget.onLongPress,
      onFocusChange: widget.onFocusChange,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      statesController: widget.statesController,
      onHover: widget.onHover,
      style: ButtonStyle(
        fixedSize: MaterialStatePropertyAll(Size.fromHeight(widget.height)),
        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        padding: const MaterialStatePropertyAll(EdgeInsets.zero),
        shadowColor: const MaterialStatePropertyAll(Colors.transparent),
        backgroundColor: MaterialStatePropertyAll(c.withOpacity(widget.fade ? 0.3 : 1)),
        foregroundColor: MaterialStatePropertyAll(widget.fade ? c : Colors.white),
      ),
      child: _loading && widget.showLoading
          ? SpinKitThreeBounce(
              color: widget.fade ? c : Colors.white,
              size: 18,
            )
          : widget.child ?? Text(widget.label),
    );
  }
}
