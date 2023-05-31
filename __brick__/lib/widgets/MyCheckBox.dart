import 'package:flutter/material.dart';
import '../core/constants/ui.dart';

class MyCheckBox extends StatelessWidget {
  final bool value;
  final void Function(bool?) onChanged;


  const MyCheckBox({Key? key, required this.value, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 25,
      height: 25,
      child: TextButton(
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero, backgroundColor: Colors.white, foregroundColor: MyColors.black),
        onPressed: () {
          onChanged(!value);
        },
        child: Icon(
          value ? Icons.check_box_rounded :  Icons.check_box_outline_blank_rounded,
          color: MyColors.lightIshBlue,
          size: 25,
        ),
      ),
    );
  }
}
