import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

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
  final double? fontSize;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final bool isPassword;
  final ValueChanged<String>? onSubmit;
  final String? placeholder;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final bool showClearButton;
  final bool locked;
  final bool required;
  final double height;

  const MyTextField({
    Key? key,
    this.label,
    this.controller,
    this.focusNode,
    this.maxLength,
    this.placeholder,
    this.height = 40,
    this.fontSize = 14,
    this.keyboardType,
    this.inputFormatters,
    this.onSubmit,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.style,
    this.strutStyle,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.showClearButton = false,
    this.locked = false,
    this.required = false,
    this.validator,
    this.prefix,
    this.prefixIcon,
    this.suffixIcon,
    this.suffix,
    this.onChanged,
    this.autofocus = false,
    this.isPassword = false,
    this.readOnly = false,
  }) : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  String? _errorMsg;
  bool obscureText = false;

  @override
  void initState() {
    if (mounted) {
      if (widget.controller != null) {
        widget.controller!.addListener(() {
          _errorMsg = widget.validator?.call(widget.controller!.text);
          widget.onChanged?.call(widget.controller!.text);
          // setState(() {});
        });
      }
      obscureText = widget.isPassword;
      super.initState();
    }
  }

  @override
  void dispose() {
    // if(mounted) {
    //   widget.controller?.removeListener(() { });
    // }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: IntrinsicHeight(
        child: Stack(
          children: [
            TextFormField(
              enabled: !widget.locked,
              onFieldSubmitted: widget.onSubmit,
              inputFormatters: widget.inputFormatters,
              maxLength: widget.maxLength,
              controller: widget.controller,
              focusNode: widget.focusNode,
              style: TextStyle(fontSize: widget.fontSize),
              obscureText: obscureText,
              // onChanged: widget.onChanged,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: widget.placeholder,
                prefixIcon: widget.prefixIcon,
                prefix: widget.prefix,
                suffix: widget.suffix,
                hintStyle: const TextStyle(color: Colors.black26, fontSize: 12),
                suffixIcon: widget.locked
                    ? const Icon(Icons.lock)
                    : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    widget.isPassword
                        ? GestureDetector(
                        onTap: () {
                          obscureText = !obscureText;
                          setState(() {});
                        },
                        child: Icon(obscureText ? Ionicons.eye : Ionicons.eye_off, size: 20))
                        : const SizedBox(),
                    widget.suffixIcon ?? const SizedBox(),
                    widget.showClearButton
                        ? GestureDetector(
                      child: const Icon(Icons.clear),
                      onTap: () {
                        widget.controller?.clear();
                      },
                    )
                        : const SizedBox()
                  ],
                ),
                counterText: '',
                label: widget.label == null
                    ? null
                    : widget.required
                    ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(widget.label ?? ''),
                    const SizedBox(width: 4),
                    const Icon(Icons.circle, color: Colors.red, size: 7.5),
                  ],
                )
                    : Text(widget.label!),
                // hintText: widget.label,
                errorText: null,
                // border: OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                border: MaterialStateOutlineInputBorder.resolveWith(
                      (states) {
                    Color borderColor = MyColors.black;
                    double borderWidth = 1;
                    if (_errorMsg != null) {
                      borderColor = MyColors.red;
                      borderWidth = 2;
                      return OutlineInputBorder(borderSide: BorderSide(color: borderColor, width: borderWidth));
                    }
                    if (states.isEmpty) return const OutlineInputBorder(borderSide: BorderSide(color: Colors.black26));
                    if (states.contains(MaterialState.disabled)) {
                      borderColor = MyColors.greyBG;
                      borderWidth = 1;
                      return OutlineInputBorder(borderSide: BorderSide(color: borderColor, width: borderWidth));
                    }
                    if (states.contains(MaterialState.error) || _errorMsg != null) {
                      borderColor = MyColors.red;
                      borderWidth = 2;
                      return OutlineInputBorder(borderSide: BorderSide(color: borderColor, width: borderWidth));
                    }
                    if (states.contains(MaterialState.focused)) {
                      borderColor = MyColors.boardingBlue;
                      borderWidth = 2;
                      return OutlineInputBorder(borderSide: BorderSide(color: borderColor, width: borderWidth));
                    }
                    if (states.contains(MaterialState.hovered)) {
                      borderColor = MyColors.black1;
                      borderWidth = 1.5;
                      return OutlineInputBorder(borderSide: BorderSide(color: borderColor, width: borderWidth));
                    }
                    return OutlineInputBorder(borderSide: BorderSide(color: borderColor, width: borderWidth));
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(left: 4, right: 4, bottom: 4),
                child: Text(
                  _errorMsg ?? '',
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyInputFormatter {
  MyInputFormatter._();

  static TextInputFormatter justNumber = FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));

  static TextInputFormatter justText = FilteringTextInputFormatter.allow(RegExp(r'[A-z]'));

  static TextInputFormatter numberWithOption = FilteringTextInputFormatter.allow(RegExp(r'^[\d\(\)\-+]+$'));

  // static TextInputFormatter numberFormatter = MaskTextInputFormatter(mask: '###,###,###,###', filter: {"#": RegExp(r'[0-9]')});
  //
  // static TextInputFormatter dateFormatter = MaskTextInputFormatter(mask: '####-##-##', filter: {"#": RegExp(r'[0-9]')});

  static TextInputFormatter uppercase = UpperCaseTextFormatter();
}

TextEditingController tcFromIntValue(int? num, {bool isZeroValid = true}) {
  if (num == null) return TextEditingController();
  if (isZeroValid) {
    TextEditingController tc = TextEditingController.fromValue(TextEditingValue(text: num == 0 ? "0" : num.toString(), selection: TextSelection.fromPosition(TextPosition(offset: num.toString().length))));
    return tc;
  } else {
    String numS = num == 0 ? "" : "$num";
    TextEditingController tc = TextEditingController.fromValue(TextEditingValue(text: numS, selection: TextSelection.fromPosition(TextPosition(offset: numS.length))));
    return tc;
  }
}

TextEditingController tcFromStrValue(String val) {
  TextEditingController tc = TextEditingController.fromValue(TextEditingValue(text: val, selection: TextSelection.fromPosition(TextPosition(offset: val.length))));
  return tc;
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
