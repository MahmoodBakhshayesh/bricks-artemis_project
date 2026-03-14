import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class LabeledCheckBox extends StatefulWidget {
  const LabeledCheckBox({super.key, required this.label, this.initialValue = false, this.onChanged, this.foregroundColor});

  final String? label;
  final bool initialValue;
  final ValueChanged<bool>? onChanged;
  final Color? foregroundColor;

  @override
  State<LabeledCheckBox> createState() => _LabeledCheckBoxState();
}

class _LabeledCheckBoxState extends State<LabeledCheckBox> {
  bool _isChecked = false;

  @override
  void initState() {
    _isChecked = widget.initialValue;
    super.initState();
  }

  void onCheckedChanged(bool value) {
    setState(() {
      _isChecked = value;
    });
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onChanged == null ? null : () => onCheckedChanged(!_isChecked),
        borderRadius: BorderRadius.circular(8),
        canRequestFocus: false,
        child: Row(
          children: [
            Checkbox(
              value: _isChecked,
              activeColor: widget.foregroundColor,
              side: const BorderSide(width: 2, color: Color(0xff919191)),
              onChanged: widget.onChanged == null
                  ? null
                  : (value) {
                      if (value == null) return;
                      onCheckedChanged(value);
                    },
            ),
            if (widget.label != null)
              Flexible(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: TextStyle(color: _isChecked ? (widget.foregroundColor ?? const Color(0xff343330)) : const Color(0xff343330)),
                  child: AutoSizeText(
                    widget.label!,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
