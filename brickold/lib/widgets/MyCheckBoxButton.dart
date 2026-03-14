import 'package:flutter/material.dart';
import '../core/constants/ui.dart';

class MyCheckBoxButton extends StatelessWidget {
  final bool value;
  final void Function(bool v) onChanged;
  final String label;
  final Widget? labelWidget;
  final bool isVertical;

  const MyCheckBoxButton({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.label,
    this.labelWidget,
    this.isVertical = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero, backgroundColor: Colors.white, foregroundColor: MyColors.black),
      onPressed: () {
        onChanged(!value);
      },
      child: isVertical
          ? Column(
              children: [
                const SizedBox(height: 4),
                Icon(
                  value ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded,
                  color: !value ? MyColors.black : MyColors.lightIshBlue,
                  size: 20,
                ),
                const SizedBox(height: 4),
                labelWidget ?? Text(label),
                const SizedBox(height: 4),
              ],
            )
          : Row(
              children: [
                const SizedBox(width: 4),
                Icon(
                  value ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded,
                  color: !value ? MyColors.black : MyColors.lightIshBlue,
                  size: 20,
                ),
                const SizedBox(width: 4),
                labelWidget ?? Text(label),
                const SizedBox(width: 4),
              ],
            ),
    );
  }
}
