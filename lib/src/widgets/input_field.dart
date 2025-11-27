import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final Function()? onFocusOut;
  final Function()? onFocusIn;
  final int? maxLines;
  final int? maxLength;
  final TextAlign? textAlign;
  final String? hint;
  final IconData? prefixIcon;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final Iterable<String>? autoFillHints;
  final bool? removeHorizontalDiv;
  final bool? isPasswordField;

  const PakiInputField({Key? key,
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
    this.onFocusOut,
    this.onFocusIn,
    this.maxLines,
    this.maxLength,
    this.textAlign,
    this.hint,
    this.prefixIcon,
    this.prefixWidget,
    this.suffixWidget,
    this.autoFillHints,
    this.removeHorizontalDiv,
    this.isPasswordField,
  }) : super(key: key);

  @override
  State<PakiInputField> createState() => _PakiInputFieldState();
}

class _PakiInputFieldState extends State<PakiInputField> {
  late FocusNode _focusNode;
  late ValueNotifier<bool> _obscureNotifier;

  // Configurações locais estáveis
  late TextInputType keyboardType;
  late bool willValidate;
  late bool isEnabled;
  late TextAlign textAlign;
  late bool removeHorizontalDiv;
  late bool isPasswordField;

  @override
  void initState() {
    super.initState();

    keyboardType = widget.keyboardType ?? TextInputType.text;
    willValidate = widget.willValidate ?? true;
    isEnabled = widget.isEnabled ?? true;
    textAlign = widget.textAlign ?? TextAlign.center;
    removeHorizontalDiv = widget.removeHorizontalDiv ?? false;
    isPasswordField = widget.isPasswordField ?? false;

    _obscureNotifier = ValueNotifier<bool>(widget.obscureText ?? false);

    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        widget.onFocusIn?.call();
      } else {
        widget.onFocusOut?.call();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _obscureNotifier.dispose();
    super.dispose();
  }

  String? _validator(String? value) {
    if (value!.isEmpty && willValidate) {
      return 'Campo ${widget.name} obrigatório';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final input = _buildInputField();

    return Column(
      children: [
        widget.autoFillHints != null
            ? AutofillGroup(child: input)
            : input,
        removeHorizontalDiv ? Container() : const PakiHorizontalDiv(),
      ],
    );
  }

  Widget _buildInputField() {
    return ValueListenableBuilder<bool>(
      valueListenable: _obscureNotifier,
      builder: (_, obscureValue, __) {
        return TextFormField(
          autofillHints:
          isEnabled ? widget.autoFillHints ?? const Iterable.empty() : null,
          validator: widget.customValidator ?? _validator,
          onChanged: widget.onChanged,
          onSaved: widget.onSaved,
          onFieldSubmitted: widget.onFieldSubmitted,
          onEditingComplete: widget.onEditingComplete,
          maxLines: widget.maxLines ?? 1,
          maxLength: widget.maxLength ?? TextField.noMaxLength,
          buildCounter: (
              BuildContext context, {
                required int currentLength,
                required bool isFocused,
                required int? maxLength,
              }) {
            if ((widget.maxLength ?? -1) > 0) {
              return Text(
                '$currentLength / ${widget.maxLength}',
                style: Theme.of(context).textTheme.bodySmall,
              );
            }
            return const SizedBox.shrink();
          },
          controller: widget.controller,
          focusNode: _focusNode,
          enabled: isEnabled,
          keyboardType: keyboardType,
          textAlign: textAlign,
          obscureText: isPasswordField ? obscureValue : (widget.obscureText ?? false),
          style: const TextStyle(color: pakiDefaultPrimaryColor),
          decoration: InputDecoration(
            labelText: widget.name,
            hintText: widget.hint,
            prefixIcon: widget.prefixWidget ??
                (widget.prefixIcon != null
                    ? Icon(widget.prefixIcon, color: Colors.white70)
                    : null),
            suffixIcon: _buildSuffixIcon(obscureValue),
          ),
        );
      },
    );
  }

  Widget? _buildSuffixIcon(bool obscureValue) {
    if (isPasswordField) {
      return IconButton(
        icon: Icon(Icons.remove_red_eye, color: Colors.white70),
        onPressed: () {
          _obscureNotifier.value = !obscureValue; // SEM setState
        },
      );
    }

    if (widget.suffixWidget != null) {
      return widget.suffixWidget;
    }

    return IconButton(
      onPressed: () {
        if (keyboardType == TextInputType.number) {
          widget.controller.text = '';
        } else {
          widget.controller.clear();
        }

        widget.onClear?.call();
      },
      icon: Icon(Icons.clear,
          color: isEnabled ? Colors.white70 : Colors.transparent),
    );
  }
}