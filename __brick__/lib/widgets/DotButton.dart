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
  final MaterialStatesController? statesController;
  final Widget? child;
  final IconData icon;
  final bool showLoading;
  final bool fade;
  final Color? color;

  const DotButton(
      {super.key,
      this.size = 30,
      this.onPressed,
      this.onLongPress,
      this.onHover,
      this.onFocusChange,
      this.style,
      this.focusNode,
      this.autofocus = false,
      this.statesController,
      this.child,
      required this.icon,
      this.showLoading = true,
      this.fade = true,
      this.color});

  @override
  State<DotButton> createState() => _DotButtonState();
}

class _DotButtonState extends State<DotButton> {
  bool _loading = false;
  _onTap(){
    if(widget.onPressed is AsyncCallback){
      if(_loading) return;
      _loading = true;
      setState((){});
      (widget.onPressed as AsyncCallback).call().whenComplete(() {
        _loading = false;
        setState((){});
      });
    }else{
      widget.onPressed?.call();
    }
  }
  @override
  Widget build(BuildContext context) {
    Color c = widget.onPressed==null?Colors.grey: widget.color ?? Colors.blueAccent;
    return SizedBox(
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
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
          fixedSize: MaterialStatePropertyAll(Size(widget.size,widget.size)),
          padding: const MaterialStatePropertyAll(EdgeInsets.zero),
          shadowColor: const MaterialStatePropertyAll(Colors.transparent),
          backgroundColor: MaterialStatePropertyAll(c.withOpacity(widget.fade ? 0.3 : 1)),
          foregroundColor: MaterialStatePropertyAll(widget.fade ? c : Colors.white),
        ),
        child: _loading && widget.showLoading
            ? SpinKitCircle(
                color: widget.fade ? c : Colors.white,
                size: widget.size-8,
              )
            : widget.child ?? Icon(widget.icon,size: widget.size-8,),
      ),
    );
  }
}
