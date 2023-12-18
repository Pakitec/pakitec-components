import 'package:flutter/material.dart';

import '../styles/main_style.dart';
import 'divider.dart';

class PakiInputField extends StatefulWidget {
  final String? name;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool? willValidate;
  final bool? isEnabled;
  final bool? obscureText;
  final String? Function(String? value)? customValidator;
  final Function(String value)? onChanged;
  final Function()? onClear;
  final int? maxLines;
  final TextAlign? textAlign;
  final String? hint;
  final IconData? prefixIcon;
  final Widget? prefixWidget;
  final Iterable<String>? autoFillHints;
  final bool? removeHorizontalDiv;

  const PakiInputField(
      {Key? key,
      this.name,
      required this.controller,
      this.keyboardType,
      this.willValidate,
      this.isEnabled,
      this.obscureText,
      this.customValidator,
      this.onChanged,
      this.onClear,
      this.maxLines,
      this.textAlign,
      this.hint,
      this.prefixIcon,
      this.prefixWidget,
      this.autoFillHints,
      this.removeHorizontalDiv})
      : super(key: key);

  @override
  _PakiInputFieldState createState() => _PakiInputFieldState();
}

class _PakiInputFieldState extends State<PakiInputField> {
  TextInputType keyboardType = TextInputType.text;
  bool willValidate = true;
  bool isEnabled = true;
  bool obscureText = false;
  int maxLines = 1;
  TextAlign textAlign = TextAlign.center;
  bool removeHorizontalDiv = false;

  @override
  void initState() {
    super.initState();
    if (widget.keyboardType != null) keyboardType = widget.keyboardType!;
    if (widget.willValidate != null) willValidate = widget.willValidate!;
    if (widget.isEnabled != null) isEnabled = widget.isEnabled!;
    if (widget.obscureText != null) obscureText = widget.obscureText!;
    if (widget.maxLines != null) maxLines = widget.maxLines!;
    if (widget.textAlign != null) textAlign = widget.textAlign!;
    if (widget.removeHorizontalDiv != null) removeHorizontalDiv = widget.removeHorizontalDiv!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      widget.autoFillHints != null ? AutofillGroup(child: _textFormField()) : _textFormField(),
      removeHorizontalDiv ? Container() : const PakiHorizontalDiv()
    ]);
  }

  String? _validator(String? value) {
    if (value!.isEmpty && willValidate) {
      return 'Campo ${widget.name} obrigatório';
    }
    return null;
  }

  Widget _textFormField() {
    return TextFormField(
        autofillHints: isEnabled ? widget.autoFillHints ?? const Iterable.empty() : null,
        validator: widget.customValidator ?? _validator,
        onChanged: widget.onChanged,
        maxLines: maxLines,
        controller: widget.controller,
        enabled: isEnabled,
        keyboardType: keyboardType,
        textAlign: textAlign,
        obscureText: obscureText,
        style: const TextStyle(color: primaryColor),
        decoration: InputDecoration(
            labelText: widget.name,
            hintText: widget.hint,
            prefixIcon: widget.prefixWidget ?? (widget.prefixIcon != null ? Icon(widget.prefixIcon, color: Colors.white70): null),
            suffixIcon: IconButton(
                onPressed: () {
                  if (keyboardType == TextInputType.number) {
                    try {
                      widget.controller.text = '';
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  } else {
                    widget.controller.clear();
                  }
                  if (widget.onClear != null) {
                    widget.onClear!();
                  }
                },
                icon: const Icon(Icons.clear, color: Colors.white70))));
  }
}
