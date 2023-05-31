import 'package:flutter/material.dart';

import '../core/constants/ui.dart';

class MyRadioButton extends StatelessWidget {
  final bool value;
  final void Function(bool) onChange;
  final String label;
  final EdgeInsetsGeometry? padding;
  final Widget? labelWidget;

  const MyRadioButton({
    Key? key,
    this.padding = const EdgeInsets.only(right: 8),
    required this.value,
    required this.onChange,
    required this.label,
    this.labelWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero, backgroundColor: Colors.white, foregroundColor: MyColors.black),
      onPressed: () {
        onChange(!value);
      },
      child: Container(
        padding: padding,
        child: Row(
          children: [
            const SizedBox(width: 4),
            SizedBox(
              height: 20,
              width: 20,
              child: Icon(
                // value ? ArtemisDcsIcons.radioenable : ArtemisDcsIcons.radiodisable,
                value ? Icons.radio_button_checked_sharp : Icons.radio_button_off_sharp,
                color: value ? MyColors.lightIshBlue : MyColors.lineColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 4),
            labelWidget??
            Text(label, style: const TextStyle(fontWeight: FontWeight.normal)),
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}
