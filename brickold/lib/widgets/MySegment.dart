import 'package:flutter/material.dart';
import '../core/constants/ui.dart';

class MySegment<T> extends StatelessWidget {
  final List<T> items;
  final Map<int,T>? itemsMap;
  final void Function(T) onChange;
  final String Function(T)? itemToString;
  final Widget Function(T)? itemToWidget;
  final T? value;
  final double? height;
  final Color? selectionColor;

  const MySegment({
    Key? key,
    required this.items,
    required this.onChange,
    required this.value,
    this.itemToString,
    this.itemsMap,
    this.itemToWidget,
    this.height,
    this.selectionColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height ?? 32,
        decoration: BoxDecoration(color: MyColors.white1, borderRadius: BorderRadius.circular(4), border: Border.all(color: MyColors.lineColor)),
        padding: const EdgeInsets.all(2),
        child: Row(
          children: items
              .map((e) => Expanded(
                  child: SizedBox(
                    height: (height ?? 32)-8,
                    child: TextButton(
                        style: TextButton.styleFrom(
                            alignment: Alignment.center,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            foregroundColor: e == value ? Colors.white : MyColors.black3,
                            backgroundColor: e == value ? selectionColor ?? MyColors.lightIshBlue : Colors.transparent),
                        onPressed: () {
                          onChange(e);
                        },
                        child: itemToWidget?.call(e) ??
                            Text(
                              itemToString == null ? e.toString() : itemToString!(e),
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                            )),
                  )))
              .toList(),
        ));
  }
}
