import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/extensions/context_extension.dart';
import '../../core/theme/app_colors.dart';
import 'number_input_sheet.dart';

class AppTextFormField extends StatefulWidget {
  final FocusNode? focusNode;
  final FocusNode? nextFn;
  final FocusNode? prevFn;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? padding;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final bool autofocus;
  final bool readOnly;
  final String? label;
  final TextEditingController? controller;
  final String? Function(String v)? validator;
  final double? fontSize;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;
  final bool isPassword;
  final ValueChanged<String>? onSubmit;

  /// Hint
  final String? placeholder;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? suffixIcon;
  final IconData? validationIcon;
  final ValueChanged<String>? onChanged;
  final bool showClearButton;
  final bool locked;
  final bool resetValueToInitialOnLocked;
  final bool openNumberSheet;
  final bool showLimit;
  final bool isRequired;
  final bool disabled;
  final bool labelInRow;
  final bool showError;
  final Color? validationColor;
  final Color? backgroundColor;
  final Color? headerBackgroundColor;
  final BorderRadius? borderRadius;
  final double? height;
  final double? suffixWidth;
  final BorderSide? borderSide;
  final List<int> rowLabelRatio;
  final String? initialValue;

  /// if this is true, then text field text-direction will update RTL or LTR by the first inputted lettter
  /// persian letter: RTL
  /// anything else: LTR
  final bool mustResolveTextDirectionByInput;

  const AppTextFormField({
    super.key,
    this.label,
    this.headerBackgroundColor,
    this.nextFn,
    this.rowLabelRatio = const [12, 33],
    this.validationColor,
    this.backgroundColor,
    this.prevFn,
    this.labelInRow = true,
    this.openNumberSheet = false,
    this.controller,
    this.labelStyle,
    this.focusNode,
    this.maxLength,
    this.placeholder,
    this.suffixWidth,
    this.height = 40,
    this.fontSize = 14,
    this.keyboardType,
    this.inputFormatters,
    this.onSubmit,
    this.disabled = false,
    this.showError = true,
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.style,
    this.strutStyle,
    this.textDirection,
    this.validationIcon,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.showClearButton = false,
    this.locked = false,
    this.resetValueToInitialOnLocked = true,
    this.showLimit = false,
    this.isRequired = false,
    this.validator,
    this.prefix,
    this.borderSide,
    this.prefixIcon,
    this.suffixIcon,
    this.suffix,
    this.maxLines = 1,
    this.onChanged,
    this.padding,
    this.minLines,
    this.autofocus = false,
    this.isPassword = false,
    this.readOnly = false,
    this.initialValue,
    this.mustResolveTextDirectionByInput = false,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool _obscureText = false;
  late final TextEditingController txtController;

  // Used to force rebuilds when the text controller changes.
  final ValueNotifier<int> _controllerUpdateNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
    txtController = widget.controller ?? TextEditingController(text: widget.initialValue);
    txtController.addListener(_onControllerUpdate);
  }

  @override
  void didUpdateWidget(covariant AppTextFormField oldWidget) {
    if (oldWidget.locked != widget.locked) {
      if (widget.locked == true) {
        txtController.removeListener(_onControllerUpdate);
        txtController.text = widget.initialValue ?? '';
        txtController.addListener(_onControllerUpdate);
      }
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    txtController.removeListener(_onControllerUpdate);
    _controllerUpdateNotifier.dispose();
    super.dispose();
  }

  void _onControllerUpdate() {
    widget.onChanged?.call(txtController.text);
    // Notify the ValueListenableBuilder to rebuild the widget and re-run validation.
    _controllerUpdateNotifier.value++;
  }

  void toggleObscure() => setState(() => _obscureText = !_obscureText);

  void _onTap() async {
    if (!widget.openNumberSheet) return;
    showModalBottomSheet<String>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (_) => NumericInputSheet(
        label: widget.label ?? '',
        maxLength: widget.maxLength,
        onDone: (a) {
          if (a is String) {
            txtController.text = a;
            widget.onSubmit?.call(a);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Rebuild whenever the controller text changes to re-evaluate the validator.
    return ValueListenableBuilder(
      valueListenable: _controllerUpdateNotifier,
      builder: (context, _, _) {
        // bool validationMode = ref.watch(globalFormValidationMode) && widget.required && _txtController.text.isEmpty;
        final BoxBorder border = BoxBorder.all(color: Colors.transparent);
        final String? errorText = widget.validator?.call(txtController.text);
        final bool hasError = errorText?.isNotEmpty ?? false;

        return GestureDetector(
          onTap: widget.locked ? null : _onTap,
          child: AbsorbPointer(
            absorbing: widget.openNumberSheet,
            child: ClipRRect(
              borderRadius: widget.borderRadius ?? BorderRadius.zero,
              child: widget.labelInRow ? _buildLabelInRow(border, hasError, errorText) : _buildLabelInColumn(border, hasError, errorText),
            ),
          ),
        );
      },
    );
  }

  // --- Builder methods to reduce duplication ---

  Widget _buildLabelInRow(BoxBorder? border, bool hasError, String? errorText) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: widget.rowLabelRatio[0],
          child: Container(
            height: widget.height,
            color: widget.headerBackgroundColor,
            alignment: Alignment.center,
            child: _buildLabelContainer(),
          ),
        ),
        Expanded(
          flex: widget.rowLabelRatio[1],
          child: Container(
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              border: border,
              borderRadius: BorderRadiusDirectional.horizontal(end: Radius.circular(widget.borderRadius?.bottomRight.x ?? 0)),
            ),
            height: widget.height,
            child: _buildTextFieldRow(hasError: hasError, errorText: errorText),
          ),
        ),
      ],
    );
  }

  Widget _buildLabelInColumn(BoxBorder? border, bool hasError, String? errorText) {
    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        _buildLabelContainer(),
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: widget.borderRadius,
            ),
            alignment: .center,
            child: _buildTextFieldRow(hasError: hasError, errorText: errorText),
          ),
        ),
      ],
    );
  }

  Widget _buildLabelContainer() {
    if (widget.label == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: IgnorePointer(
        child: Row(
          mainAxisSize: .min,
          children: [
            Text(
              widget.label ?? '',
              style: widget.labelStyle ?? const TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
            ),
            if (widget.isRequired)
              const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Icon(Icons.star_rate_rounded, color: Colors.red, size: 8),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldRow({required bool hasError, required String? errorText}) {
    return Row(
      children: [
        Expanded(child: _buildCupertinoTextField()),
        if (hasError && widget.showError) Expanded(child: _buildErrorWidget(errorText)),
      ],
    );
  }

  Widget _buildCupertinoTextField() {
    final bool hasText = txtController.text.isNotEmpty;
    final List<Widget> suffixWidgets = [];

    // The primary suffix can be a password toggle or a custom icon. They are mutually exclusive.
    if (widget.isPassword) {
      suffixWidgets.add(
        ExcludeFocus(
          child: IconButton(
            style: IconButton.styleFrom(tapTargetSize: .shrinkWrap),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(width: 32, height: 32),
            onPressed: widget.disabled ? null : toggleObscure,
            icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off, size: 18, color: AppColors.textColor.withValues(alpha: 0.7)),
            tooltip: _obscureText ? 'Show password' : 'Hide password',
          ),
        ),
      );
    } else if (widget.suffixIcon != null) {
      suffixWidgets.add(widget.suffixIcon!);
    }

    // The clear button can be added alongside the primary suffix.
    if (widget.showClearButton && hasText) {
      suffixWidgets.insert(0, _buildClearButton(context));
    }

    Widget? finalSuffix;
    if (suffixWidgets.isNotEmpty) {
      finalSuffix = Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: suffixWidgets,
      );
    }

    return CupertinoTextField(
      textInputAction: widget.textInputAction ?? TextInputAction.done,
      textAlignVertical: TextAlignVertical.center,
      padding: widget.padding ?? const EdgeInsets.all(7.0),
      enabled: !widget.locked && !widget.disabled,
      maxLines: _obscureText ? 1 : (widget.maxLines == 0 ? null : widget.maxLines),
      maxLength: widget.maxLength,
      focusNode: widget.focusNode,
      readOnly: (widget.locked || widget.readOnly || widget.openNumberSheet),
      onSubmitted: widget.onSubmit,
      keyboardType: widget.keyboardType,
      textAlign: widget.textAlign,
      textDirection: _resolveTextDirection(),
      obscureText: _obscureText,
      autofocus: widget.autofocus,
      inputFormatters: [

        ...(widget.inputFormatters ?? []),
      ],
      style: widget.style,
      placeholder: widget.placeholder,
      placeholderStyle: const TextStyle(color: Color(0xffC4C4C4)),
      prefix: widget.prefixIcon ?? widget.prefix,
      suffix: finalSuffix,
      decoration: BoxDecoration(
        color: widget.locked ? const Color(0xffF1F6FF) : widget.backgroundColor,
        borderRadius: widget.borderRadius,
        border: widget.borderSide == null ? null : Border.fromBorderSide(widget.borderSide!),
      ),
      controller: txtController,
    );
  }

  TextDirection? _resolveTextDirection() {
    if (widget.textDirection != null) return widget.textDirection!;
    if (widget.mustResolveTextDirectionByInput == false) return null;

    final text = txtController.text;
    final trimmedText = text.trimLeft();
    if (trimmedText.isEmpty) return null;

    final firstChar = trimmedText[0];
    // Check for Persian/Arabic characters
    final isRtl = RegExp(r'[\u0600-\u06FF\uFB50-\uFDFF\uFE70-\uFEFF]').hasMatch(firstChar);
    return isRtl ? TextDirection.rtl : TextDirection.ltr;
  }

  Widget _buildErrorWidget(String? errorText) {
    final validationColor = widget.validationColor ?? Colors.red;
    return Container(
      height: widget.labelInRow ? widget.height : (widget.height ?? 40) - 12,
      margin: const EdgeInsets.only(left: 12),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: validationColor),
        color: validationColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          if (widget.validationIcon != null) Icon(widget.validationIcon!, color: validationColor, size: 20),
          Expanded(
            child: Text(
              errorText ?? '',
              style: TextStyle(color: validationColor, fontSize: 9, height: 1),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClearButton(BuildContext context) {
    return ExcludeFocus(
      child: IconButton(
        style: IconButton.styleFrom(tapTargetSize: .shrinkWrap),
        tooltip: context.localizations.clear,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints.tightFor(width: 32, height: 32),
        onPressed: () {
          txtController.clear();
          // The listener will automatically handle the onChanged call and rebuild.
        },
        icon: Icon(Icons.clear, size: 18, color: AppColors.textColor.withValues(alpha: 0.7)),
      ),
    );
  }
}
