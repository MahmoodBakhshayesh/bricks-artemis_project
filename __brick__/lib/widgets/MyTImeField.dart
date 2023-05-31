import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../core/constants/ui.dart';

class MyTimeField extends StatelessWidget {
  final String? label;
  final String? value;
  final Color labelColor;
  final Color valueColor;
  final Color backgroundColor;
  final double height;
  final bool locked;
  final void Function()? onChange;

  const MyTimeField({
    Key? key,
    this.backgroundColor = MyColors.white2,
    this.label = "Label",
    this.value = "Time",
    this.onChange,
    this.labelColor = MyColors.lightIshBlue,
    this.valueColor = MyColors.black1,
    this.height = 50,
    this.locked=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double ratio = (height/50);
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                width: 1.5,
                color:locked?Colors.black:  MyColors.veryLightPink,
              )),
          height: 50,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            ),
            onPressed:locked?null: onChange,
            child: Row(
              children: [
                Text(
                  "$label",
                  style: TextStyle(fontSize: 12, color: labelColor,fontWeight: FontWeight.normal),
                ),
                const Spacer(),
                Text(
                  value ?? "Time",
                  style: TextStyle(fontSize: 12, color: valueColor),
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor,
            ),
            height: 30*ratio,
            width: 30*ratio,
            padding: const EdgeInsets.all(4),
            child:  SizedBox(
                child: Icon(locked? Icons.lock:
                  Ionicons.time,
                  size: 20,
                  color:locked?Colors.black: MyColors.veryLightPink,
                )),
          ),
        )
      ],
    );
  }
}
