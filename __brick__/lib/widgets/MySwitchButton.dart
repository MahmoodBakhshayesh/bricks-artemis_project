import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../core/constants/ui.dart';

class MySwitchButton extends StatelessWidget {
  final bool value;
  final void Function(bool v) onChange;
  final String label;
  final Widget? labelWidget;
  final Color? color;

  const MySwitchButton({Key? key,this.labelWidget, required this.value, required this.onChange, required this.label, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return TextButton.icon(
      style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          foregroundColor:color?? MyColors.black,
      ),
      onPressed: () {
        onChange(!value);
      },
      icon:SizedBox(
        height: 15,
        width: 30,
        child: Transform.scale(
          scale: 0.75,
          child: CupertinoSwitch(
            value: value, onChanged: onChange,activeColor:color?? MyColors.greenishTeal,),
        ),
      ),
      label: Padding(
        padding: const EdgeInsets.only(left: 0),
        child:labelWidget?? Text(label),
      ),
    );
  }
}
