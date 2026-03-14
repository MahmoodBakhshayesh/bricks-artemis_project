import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/extensions/context_extension.dart';
import 'numeric_keyboard.dart';

class NumericInputSheet extends StatefulWidget {
  final String label;
  final int? maxLength;
  final Function onDone;

  const NumericInputSheet({super.key, required this.label, this.maxLength, required this.onDone});

  @override
  State<NumericInputSheet> createState() => _NumericInputSheetState();
}

class _NumericInputSheetState extends State<NumericInputSheet> {
  final idC = TextEditingController();

  @override
  void initState() {
    super.initState();
    idC.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    idC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom > 30;
    return SafeArea(
      bottom: true,
      child: Container(
        constraints: BoxConstraints(maxHeight: (context.height * 0.9)),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, // pushes above keyboard
        ),
        // height: context.height*0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                const SizedBox(width: 12),
                Expanded(child: Text(widget.label)),
                const CloseButton(),
              ],
            ),
            const Divider(),
            SingleChildScrollView(
              child: Column(
                spacing: 12,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CupertinoTextField(
                      enabled: false,
                      maxLength: widget.maxLength,
                      textAlign: TextAlign.center,
                      decoration: BoxDecoration(borderRadius: BorderRadiusGeometry.circular(8)),
                      style: const TextStyle(fontSize: 40),
                      placeholder: widget.label,
                      controller: idC,
                    ),
                  ),
                  CupertinoNumericKeyboard(
                    maxLength: widget.maxLength,
                    controller: idC,
                    onDone: () async {
                      await widget.onDone(idC.text);
                      if (context.mounted) Navigator.of(context).pop(idC.text);
                    },
                  ),
                ],
              ),
            ),
            // Divider(),
            // Padding(
            //   padding: const EdgeInsets.all(12.0),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: MyButton(
            //           color: Colors.grey,
            //           borderSide: BorderSide(color: MyColors.lineColor),
            //           reverse: true,
            //           label: "Cancel",
            //           onPressed: () {
            //             Navigator.of(context).pop();
            //           },
            //         ),
            //       ),
            //       const SizedBox(width: 12),
            //       Expanded(
            //         child: MyButton(
            //           label: "Confirm",
            //           onPressed: () async {
            //             Navigator.of(context).pop(idC);
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
