import 'package:flutter/material.dart';
import '../core/constants/ui.dart';

class MyTextField extends StatefulWidget {
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final bool autofocus;
  final bool readOnly;
  final String? label;
  final TextEditingController? controller;
  final String? Function(String v)? validator;

  const MyTextField({
    Key? key,
    this.label,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.style,
    this.strutStyle,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.validator,
    this.autofocus = false,
    this.readOnly = false,
  }) : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  String? _errorMsg;


  @override
  void initState() {
    if(widget.controller!=null) {
      widget.controller!.addListener(() {
        _errorMsg = widget.validator?.call(widget.controller!.text);
        setState(() {});
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    widget.controller?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: IntrinsicHeight(
        child: Stack(
          children: [
            TextFormField(
              controller: widget.controller,
              decoration: InputDecoration(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(widget.label??''),
                    const SizedBox(width: 4),
                    const Icon(Icons.circle,color: Colors.red,size: 7.5)
                  ],
                ),
                // hintText: widget.label,
                errorText:null,
                // border: OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                border: MaterialStateOutlineInputBorder.resolveWith(
                  (states) {
                    Color borderColor = MyColors.black;
                    double borderWidth = 1;
                    if( _errorMsg!=null){
                      borderColor = MyColors.red;
                      borderWidth = 2;
                      return OutlineInputBorder(borderSide: BorderSide(color: borderColor,width: borderWidth));
                    }
                    if (states.isEmpty) return const OutlineInputBorder(borderSide: BorderSide(color: Colors.black26));
                    if(states.contains(MaterialState.disabled)){
                      borderColor = MyColors.greyBG;
                      borderWidth = 1;
                      return OutlineInputBorder(borderSide: BorderSide(color: borderColor,width: borderWidth));
                    }
                    if(states.contains(MaterialState.error) || _errorMsg!=null){
                      borderColor = MyColors.red;
                      borderWidth = 2;
                      return OutlineInputBorder(borderSide: BorderSide(color: borderColor,width: borderWidth));
                    }
                    if(states.contains(MaterialState.focused)){
                      borderColor = MyColors.boardingBlue;
                      borderWidth = 2;
                      return OutlineInputBorder(borderSide: BorderSide(color: borderColor,width: borderWidth));
                    }
                    if(states.contains(MaterialState.hovered)){
                      borderColor = MyColors.black1;
                      borderWidth = 1.5;
                      return OutlineInputBorder(borderSide: BorderSide(color: borderColor,width: borderWidth));
                    }
                    return OutlineInputBorder(borderSide: BorderSide(color: borderColor,width: borderWidth));
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(left: 4,right: 4,bottom: 4),
                child: Text(_errorMsg??'',style: const TextStyle(color: Colors.red,fontSize: 12),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
