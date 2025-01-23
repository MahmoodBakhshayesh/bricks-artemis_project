import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DotButton extends StatefulWidget {
  final double size;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool autofocus;
  final WidgetStatesController? statesController;
  final Widget? child;
  final IconData icon;
  final bool showLoading;
  final bool fade;
  final bool flat;
  final Color? color;
  final Color? backgroundColor;
  final BorderSide? border;
  final String? badge;
  final double radius;
  final double? iconSize;

  const DotButton(
      {super.key,
        this.size = 30,
        this.radius = 5,
        this.onPressed,
        this.onLongPress,
        this.onHover,
        this.onFocusChange,
        this.style,
        this.focusNode,
        this.autofocus = false,
        this.statesController,
        this.child,
        this.border,
        this.iconSize,
        this.backgroundColor,
        this.badge,
        required this.icon,
        this.showLoading = true,
        this.fade = true,
        this.flat = false,
        this.color});

  @override
  State<DotButton> createState() => _DotButtonState();
}

class _DotButtonState extends State<DotButton> {
  bool _loading = false;

  _onTap() {
    if (widget.onPressed is AsyncCallback) {
      if (_loading) return;
      _loading = true;
      if(mounted){
        setState(() {});
      }

      (widget.onPressed as AsyncCallback).call().whenComplete(() {
        _loading = false;
        if(mounted){
          setState(() {});
        }
      });
    } else {
      widget.onPressed?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    Color c = widget.onPressed == null ? Colors.black12 : widget.color ?? Colors.blueAccent;
    double iconSize = widget.size * 0.6;
    if (widget.badge != null) {
      return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: widget.size,
              height: widget.size,
              child: ElevatedButton(
                onPressed: _onTap,
                onLongPress: widget.onLongPress,
                onFocusChange: widget.onFocusChange,
                autofocus: widget.autofocus,
                focusNode: widget.focusNode,
                statesController: widget.statesController,
                onHover: widget.onHover,
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.radius), side: widget.border ?? BorderSide.none)),
                  fixedSize: WidgetStatePropertyAll(Size(widget.size, widget.size)),
                  padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                  shadowColor: const WidgetStatePropertyAll(Colors.transparent),
                  backgroundColor: WidgetStatePropertyAll(
                      widget.backgroundColor??
                          c.withOpacity(widget.flat
                              ? 0
                              : widget.fade
                              ? 0.3
                              : 1)),
                  foregroundColor: WidgetStatePropertyAll(widget.fade ? c : Colors.white),
                ),
                child: _loading && widget.showLoading
                    ? SpinKitCircle(
                  color: widget.fade ? c : Colors.white,
                  size: iconSize,
                )
                    : widget.child ??
                    Icon(
                      widget.icon,
                      color: c,
                      size: iconSize,
                    ),
              ),
            ),
          ),
          Positioned(
              top: 0,
              right: 0,
              child: Badge(
                padding: EdgeInsets.symmetric(horizontal: 2,vertical: 1),
                label: Text(widget.badge!),
                textStyle: TextStyle(fontSize: 9,fontWeight: FontWeight.bold),
                backgroundColor: widget.border?.color??c,
              ))
        ],
      );
    }
    return ExcludeFocus(
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: ElevatedButton(
          onPressed: _onTap,
          onLongPress: widget.onLongPress,
          onFocusChange: widget.onFocusChange,
          autofocus: widget.autofocus,
          focusNode: widget.focusNode,
          statesController: widget.statesController,
          onHover: widget.onHover,
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.radius), side: widget.border ?? BorderSide.none)),
            fixedSize: WidgetStatePropertyAll(Size(widget.size, widget.size)),
            padding: const WidgetStatePropertyAll(EdgeInsets.zero),
            shadowColor: const WidgetStatePropertyAll(Colors.transparent),
            backgroundColor: WidgetStatePropertyAll(widget.backgroundColor??c.withOpacity(widget.flat
                ? 0
                : widget.fade
                ? 0.3
                : 1)),
            foregroundColor: WidgetStatePropertyAll(widget.fade ? c : Colors.white),
          ),
          child: _loading && widget.showLoading
              ? SpinKitCircle(
            color: widget.fade ? c : Colors.white,
            size: iconSize,
          )
              : widget.child ??
              Icon(
                widget.icon,
                color: widget.fade ? c : Colors.white,
                size: iconSize,
              ),
        ),
      ),
    );
  }
}
