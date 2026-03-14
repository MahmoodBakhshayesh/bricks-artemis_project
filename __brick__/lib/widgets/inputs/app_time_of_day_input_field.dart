import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/extensions/time_of_day_extension.dart';
import '../../core/helpers/time_picker_utils.dart';
import 'app_text_form_field.dart';

class AppTimeOfDayInputField extends StatefulWidget {
  const AppTimeOfDayInputField({
    super.key,
    required this.onChanged,
    required this.initialValue,
    this.label,
    required this.isRequired,
    required this.locked,
  });

  final ValueChanged<TimeOfDay>? onChanged;
  final TimeOfDay? initialValue;
  final String? label;
  final bool isRequired;
  final bool locked;

  @override
  State<AppTimeOfDayInputField> createState() => _AppTimeOfDayInputFieldState();
}

class _AppTimeOfDayInputFieldState extends State<AppTimeOfDayInputField> {
  late final txtController = TextEditingController(text: widget.initialValue?.toJson);

  @override
  void didUpdateWidget(covariant AppTimeOfDayInputField oldWidget) {
    if (oldWidget.initialValue != widget.initialValue) {
      setState(() {
        txtController.text = widget.initialValue?.toJson ?? '';
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> onTimePickerPressed(BuildContext context) async {
    final pickedTime = await TimePickerUtils.show(
      context,
      title: widget.label,
      initialTime: widget.initialValue,
      timePickerEntryMode: TimePickerEntryMode.input,
    );
    if (pickedTime == null) return;

    txtController.text = pickedTime.toJson!;
    widget.onChanged?.call(pickedTime);
  }

  @override
  void dispose() {
    txtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.locked ? null : () => onTimePickerPressed(context),
      child: AbsorbPointer(
        absorbing: true,
        child: AppTextFormField(
          controller: txtController,
          locked: widget.locked,
          readOnly: true,
          isRequired: widget.isRequired,
          label: widget.label,
          labelStyle: const TextStyle(fontSize: 11, color: Color(0xff111111), fontWeight: FontWeight.w600),
          labelInRow: false,
          borderSide: const BorderSide(color: Color(0xff919191)),
          initialValue: widget.initialValue?.toJson,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: const TextStyle(color: Color(0xff40649E), fontWeight: FontWeight.w600),
          textAlign: .center,
        ),
      ),
    );
  }
}
