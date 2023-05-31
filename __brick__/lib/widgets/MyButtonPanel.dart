import 'package:flutter/material.dart';
import '../core/constants/ui.dart';

class MyButtonPanel extends StatelessWidget {
  final Widget? centerWidget;
  final Widget? leftWidget;
  final Widget? rightWidget;
  final void Function()? centerAction;
  final void Function()? rightAction;
  final void Function()? leftAction;
  final double size;
  final double radius;
  final Color backgroundColor;
  final Color linesColor;

  const MyButtonPanel(
      {super.key,
      this.centerWidget,
      this.backgroundColor = MyColors.white2,
      this.linesColor = MyColors.veryLightPink,
      this.size = 40,
      this.radius = 5,
      this.leftWidget,
      this.rightWidget,
      this.centerAction,
      this.rightAction,
      this.leftAction});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      children: [
        SizedBox(
            width: size,
            height: size,
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    side: BorderSide(width: 1, color: linesColor),
                    backgroundColor: backgroundColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radius),
                      bottomLeft: Radius.circular(radius),
                    ))),
                onPressed: leftAction,
                child: leftWidget ?? const Icon(Icons.arrow_forward_ios_sharp, size: 14, color: MyColors.brownGrey))),
        Expanded(
          child: SizedBox(
            height: size,
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(side: BorderSide(width: 1, color: linesColor), backgroundColor: backgroundColor, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
                onPressed: centerAction,
                child: centerWidget ??
                    Text(
                      "-",
                      style: theme.textTheme.headlineSmall,
                    )),
          ),
        ),
        SizedBox(
            width: size,
            height: size,
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    side: BorderSide(width: 1, color: linesColor),
                    backgroundColor: backgroundColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(radius),
                      topRight: Radius.circular(radius),
                    ))),
                onPressed: rightAction,
                child: rightWidget ??
                    const Icon(
                      Icons.arrow_back_ios_sharp,
                      size: 14,
                      color: MyColors.brownGrey,
                    ))),
      ],
    );
  }
}
