import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Field extends StatefulWidget {
  const Field({
    Key? key,
    this.height = 26,
    this.width,
    this.showBorder = true,
    this.contentPadding,
    this.isEnabled = true,
    this.isNumberInput = false,
    this.style,
    this.hint,
    this.hintStyle,
    this.maxLines,
    this.borderSide,
    this.textAlign,
    this.controller,
    this.focusNode,
    this.formatters,
    this.suffix,
    this.color = Colors.white,
    this.onChanged,
    this.suffixText,
    this.borderRadius,
    this.prefix,
  }) : super(key: key);
  final double? height;
  final bool showBorder;
  final BorderSide? borderSide;
  final bool isEnabled;
  final bool isNumberInput;
  final double? width;
  final TextAlign? textAlign;
  final List<TextInputFormatter>? formatters;
  final Color? color;
  final String? hint;
  final String? suffixText;
  final TextStyle? hintStyle;
  final Widget? suffix;
  final Widget? prefix;
  final int? maxLines;
  final TextStyle? style;
  final Function(String?)? onChanged;
  final EdgeInsets? contentPadding;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final BorderRadius? borderRadius;

  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: TextField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        onChanged: widget.onChanged,
        textAlignVertical: TextAlignVertical.center,
        enabled: widget.isEnabled,
        style:
            widget.style ?? const TextStyle(fontSize: 12, color: Colors.black),
        maxLines: widget.maxLines,
        textAlign: widget.textAlign ?? TextAlign.start,
        keyboardType:
            widget.isNumberInput ? TextInputType.number : TextInputType.text,
        inputFormatters: widget.isNumberInput
            ? [
                FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                TextInputFormatter.withFunction((oldValue, newValue) {
                  try {
                    final text = newValue.text;
                    if (text.isNotEmpty) double.parse(text);
                    return newValue;
                  } catch (e) {
                    return oldValue;
                  }
                }),
                ...widget.formatters ?? [],
              ]
            : widget.formatters,
        decoration: InputDecoration(
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: widget.prefix,
          fillColor: widget.color,
          suffixIcon: widget.suffix == null
              ? null
              : SizedBox(
                  width: 26,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(height: 1000, child: widget.suffix!),
                    ],
                  ),
                ),
          suffixText: widget.suffixText,
          hintText: widget.hint,
          hintStyle: widget.hintStyle ??
              const TextStyle(
                color: Colors.grey,
                fontSize: 11,
              ),
          contentPadding: widget.contentPadding ??
              const EdgeInsets.symmetric(horizontal: 5),
          disabledBorder: getOutlinedBorder(),
          border: getOutlinedBorder(),
          errorBorder: getOutlinedBorder(),
          enabledBorder: getOutlinedBorder(),
          focusedBorder: getOutlinedBorder(),
          focusedErrorBorder: getOutlinedBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder getOutlinedBorder() {
    final borderRadius = widget.borderRadius ?? BorderRadius.circular(3);
    return OutlineInputBorder(
      borderSide: getBorder(),
      borderRadius: borderRadius,
    );
  }

  BorderSide getBorder() {
    return widget.borderSide != null
        ? widget.borderSide!
        : widget.showBorder
            ? const BorderSide(color: Colors.grey, width: 0.5)
            : const BorderSide(color: Colors.transparent, width: 0);
  }
}
