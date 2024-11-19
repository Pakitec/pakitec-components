import 'package:flutter/material.dart';
import 'package:pakitec_themes/pakitec_themes.dart';
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
  final Function(String? value)? onSaved;
  final Function(String value)? onFieldSubmitted;
  final Function()? onEditingComplete;
  final Function()? onClear;
  final Function()? onFocusOut; // Nova propriedade
  final int? maxLines;
  final TextAlign? textAlign;
  final String? hint;
  final IconData? prefixIcon;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final Iterable<String>? autoFillHints;
  final bool? removeHorizontalDiv;
  final bool? isPasswordField;

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
        this.onSaved,
        this.onFieldSubmitted,
        this.onEditingComplete,
        this.onClear,
        this.onFocusOut, // Nova propriedade no construtor
        this.maxLines,
        this.textAlign,
        this.hint,
        this.prefixIcon,
        this.prefixWidget,
        this.suffixWidget,
        this.autoFillHints,
        this.removeHorizontalDiv,
        this.isPasswordField})
      : super(key: key);

  @override
  State<PakiInputField> createState() => _PakiInputFieldState();
}

class _PakiInputFieldState extends State<PakiInputField> {
  TextInputType keyboardType = TextInputType.text;
  bool willValidate = true;
  bool isEnabled = true;
  bool obscureText = false;
  int maxLines = 1;
  TextAlign textAlign = TextAlign.center;
  bool removeHorizontalDiv = false;
  bool isPasswordField = false;

  bool localObscureText = true;
  late FocusNode _focusNode;

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
    if (widget.isPasswordField != null) isPasswordField = widget.isPasswordField!;

    // Inicializa o FocusNode e adiciona o listener para detectar quando o foco é perdido
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        if (widget.onFocusOut != null) {
          widget.onFocusOut!();
        }
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
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
        onSaved: widget.onSaved,
        onFieldSubmitted: widget.onFieldSubmitted,
        onEditingComplete: widget.onEditingComplete,
        maxLines: maxLines,
        controller: widget.controller,
        focusNode: _focusNode, // Adiciona o FocusNode para detectar foco
        enabled: isEnabled,
        keyboardType: keyboardType,
        textAlign: textAlign,
        obscureText: isPasswordField ? localObscureText : obscureText,
        style: const TextStyle(color: pakiDefaultPrimaryColor),
        decoration: InputDecoration(
            labelText: widget.name,
            hintText: widget.hint,
            prefixIcon: widget.prefixWidget ??
                (widget.prefixIcon != null ? Icon(widget.prefixIcon, color: Colors.white70) : null),
            suffixIcon: isPasswordField
                ? IconButton(
                icon: const Icon(Icons.remove_red_eye, color: Colors.white70),
                onPressed: () {
                  setState(() {
                    localObscureText = !localObscureText;
                  });
                })
                : widget.suffixWidget ??
                IconButton(
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
