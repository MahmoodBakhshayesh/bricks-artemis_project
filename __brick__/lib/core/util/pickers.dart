import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../initialize.dart';
import '../abstracts/device_info_service_abs.dart';
import '../constants/ui.dart';
import '../navigation/navigation_service.dart';
import '../platform/device_info.dart';

class Pickers {
  Pickers._();

  static Future<TimeOfDay?> pickTime(BuildContext context, TimeOfDay time) {
    return showTimePicker(
      context: context,
      initialTime: time,
      // initialEntryMode: DeviceInfo.deviceType(context).isPhone ? TimePickerEntryMode.dial : TimePickerEntryMode.input,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
  }

  static Future<DateTime?> pickDate(BuildContext context, DateTime dateTime, {DateTime? minDate, DateTime? maxDate}) {
    return showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: minDate ?? DateTime.now().subtract(const Duration(days: 100)),
      lastDate: maxDate ?? DateTime.now().add(const Duration(days: 100)),
    );
  }

  static Future<T?> pickItem<T>(
    BuildContext context, {
    required List<T> items,
    required String Function(T item) itemToString,
    required Widget Function(T item) itemBuilder,
  }) async {
    NavigationService navigationService = getIt<NavigationService>();
    T? value = await navigationService.dialog(ListPickerDialog(
      items: items,
      itemBuilder: itemBuilder,
      itemToString: itemToString,
    ));
    return value;
  }
}

class ListPickerDialog<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T) itemToString;
  final Widget Function(T) itemBuilder;

  const ListPickerDialog({
    Key? key,
    required this.items,
    required this.itemToString,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  State<ListPickerDialog<T>> createState() => _ListPickerDialogState<T>();
}

class _ListPickerDialogState<T> extends State<ListPickerDialog<T>> {
  TextEditingController searchC = TextEditingController();
  String searched = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchC.addListener(() {
      searched = searchC.text;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    NavigationService navigationService = getIt<NavigationService>();
    double width = Get.width;
    double height = Get.height;
    List<T> items = widget.items
        .where(
          (element) =>
              // searched.isEmpty ||
              widget.itemToString(element).toLowerCase().contains(searched.toLowerCase()),
        )
        .toList();
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        height: height * 0.5,
        constraints: BoxConstraints(minHeight: height * 0.5),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const SizedBox(width: 18),
                const Text("ListPicker", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      navigationService.popDialog();
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
            const Divider(height: 1),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: CupertinoTextField(
                prefix: const Icon(Icons.search),
                controller: searchC,
              ),
            ),
            const Divider(height: 1),
            Expanded(
              // padding: const EdgeInsets.all(18),
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (c, i) => Material(
                        color: i.isEven ? MyColors.veryLightPink : Colors.white,
                        child: InkWell(
                          onTap: () {
                            navigationService.popDialog(result: items[i]);
                            // Navigator.pop(context, items[i]);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            child: widget.itemBuilder(items[i]),
                          ),
                        ),
                      )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18, bottom: 18),
              child: Row(
                children: [
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      navigationService.popDialog();
                    },
                    style: TextButton.styleFrom(foregroundColor: MyColors.greyishBrown, backgroundColor: Colors.white),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      navigationService.popDialog();
                    },
                    style: TextButton.styleFrom(foregroundColor: Colors.blueAccent, backgroundColor: Colors.white),
                    child: const Text(
                      "Save",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
