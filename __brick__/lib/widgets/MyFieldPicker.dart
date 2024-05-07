import 'dart:math';
import 'package:artemis_ui_kit/artemis_ui_kit.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../core/utils_and_services/pickers.dart';
import 'DotButton.dart';

class MyFieldPicker<T> extends StatelessWidget {
  final DropdownSearchItemAsString<T> itemToString;
  final Color Function(T)? itemToColor;
  final Widget Function(T)? itemToWidget;
  final List<T>? items;
  final ValueChanged<T?>? onChange;
  final T? value;
  final String? label;
  final String? hint;
  final bool showClearButton;
  final bool supportNull;
  final bool locked;
  final bool hasSearch;
  final bool required;
  final bool showSelected;
  final bool ignorePhoneMode;
  final TextStyle? style;
  final bool widgetOverride;
  final Widget? overridingWidget;
  final Widget? clearButtomOverride;

  const MyFieldPicker(
      {Key? key,
      required this.itemToString,
      this.locked = false,
      this.required = false,
      this.widgetOverride = false,
      this.style,
      this.overridingWidget,
      this.showSelected = false,
      this.itemToColor,
      this.clearButtomOverride,
      required this.label,
      this.hint,
      this.items,
      this.onChange,
      this.hasSearch = false,
      this.value,
      this.showClearButton = true,
      this.supportNull = true,
      this.ignorePhoneMode = false,
      this.itemToWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool phoneMode = false;
    return GestureDetector(
      onTap: () {
        if (widgetOverride && locked) return;
        Pickers.pickItem<T>(
          context,
          items: items ?? [],
          itemToString: (a) => itemToString(a),
          itemBuilder: (T a) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            child: Row(
              children: [
                Expanded(child: itemToWidget?.call(a) ?? Text(itemToString(a))),
              ],
            ),
          ),
        ).then((value) {
          onChange?.call(value);
        });
      },
      child: AbsorbPointer(
        absorbing: (phoneMode && !ignorePhoneMode) && false,
        child: Stack(
          children: [
            DropdownSearch<T>(

              enabled: !locked,
              clearButtonProps: ClearButtonProps(
                padding: EdgeInsets.zero,
                isVisible: showClearButton,
                icon: Icon(locked ? Icons.lock : Icons.clear, size: 15),
              ),
              dropdownButtonProps: const DropdownButtonProps(isVisible: false, iconSize: 20),
              dropdownBuilder: (_, item) {
                if (widgetOverride) {
                  return const SizedBox();
                }
                if (item == null) {
                  return Text(
                    (hint ?? label ?? "Not Selected"),
                    style: const TextStyle(color: Colors.grey),
                  );
                }
                return Text(itemToString(item), style: style, overflow: TextOverflow.ellipsis);
              },
              // validator: validator,
              // autoValidateMode: autoValidateMode,
              onChanged: onChange,
              selectedItem: value,

              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration:
                    //     InputDecoration(
                    //       hintStyle: TextStyle(color: Colors.red),
                    //       suffixStyle: TextStyle(color: Colors.red),
                    //       prefixStyle: TextStyle(color: Colors.red),
                    //       labelStyle: TextStyle(color: Colors.red),
                    //       errorStyle: TextStyle(color: Colors.red),
                    //       helperStyle: TextStyle(color: Colors.red),
                    //       floatingLabelStyle: TextStyle(color: Colors.red),
                    //       counterStyle: TextStyle(color: Colors.red),
                    //     ),
                    // DeviceInfo.deviceType(context) == DeviceType.phone ?null:
                    (required ? Styles.dropDownStyleRequired : Styles.dropDownStyle).copyWith(
                  labelStyle: TextStyle(fontSize: 12, height: value == null ? 1 : 0.8),
                  labelText: label,
                  hintText: hint,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 0,
                  ),
                ),
              ),
              items: items ?? [],

              popupProps: PopupProps.menu(
                showSearchBox: hasSearch,
                showSelectedItems: showSelected,
                searchDelay: const Duration(milliseconds: 0),
                searchFieldProps: const TextFieldProps(
                    autofocus: true,
                    style: TextStyle(fontSize: 12),
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      isDense: true,
                      // prefixStyle: TextStyle(height: 11),
                      prefixText: "🔍  ",
                      // prefixIcon: Icon(ArtemisIcons.search,size: 10),
                      border: OutlineInputBorder(),
                    )),
                emptyBuilder: (c, i) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                  child: Center(child: Text("No Option", style: theme.textTheme.headline6!.copyWith(color: ArtemisColors.brownGrey))),
                ),
                itemBuilder: (c, item, i) {
                  String main = itemToString(item);
                  String sub = "";
                  if (itemToString(item).contains("(") && itemToString(item).contains(")")) {
                    main = itemToString(item).split("(")[0];
                    sub = "(${itemToString(item).split("(")[1]}";
                  }
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                        child: Center(
                            child: RichText(
                          text: TextSpan(children: [
                            TextSpan(text: main, style: TextStyle(fontSize: 16, color: itemToColor == null || item == null ? ArtemisColors.black : itemToColor!(item))),
                            TextSpan(text: sub, style: const TextStyle(fontSize: 12, color: ArtemisColors.brownGrey)),
                          ]),
                        )),
                      ),
                      const Divider(height: 3)
                    ],
                  );
                },
                constraints: BoxConstraints(
                  maxHeight: (hasSearch ? 40 : 0) + (max(min(((items ?? []).length), 5), 1)) * 35 + 10,
                ),
              ),

              itemAsString: (item) {
                String main = itemToString(item);
                return main;
              },
            ),
            !widgetOverride
                ? const SizedBox()
                : Row(
                    children: [
                      Expanded(
                        child: IgnorePointer(
                          child: Container(
                            height: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [
                                Expanded(
                                    child: value == null
                                        ? Text(
                                            hint ?? 'Not Selected',
                                            style: const TextStyle(color: Colors.grey),
                                          )
                                        : overridingWidget ??
                                            Text(
                                              itemToString(value as T),
                                              style: style,
                                            )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      showClearButton
                          ? Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: DotButton(
                                onPressed: () {
                                  onChange?.call(null);
                                },
                                icon: Icons.clear,
                              ),
                            )
                          : clearButtomOverride ?? const SizedBox()
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
