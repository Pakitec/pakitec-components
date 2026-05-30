import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:pakitec_themes/pakitec_themes.dart';

import 'divider.dart';

class PakiTextField extends StatefulWidget {
  final String? name;
  final QuillController controller;
  final bool? isEnabled;
  final bool? showToolbar;
  final bool? removeHorizontalDiv;
  final String? hint;
  final double? minHeight;
  final double? maxHeight;
  final EdgeInsetsGeometry? padding;
  final ValueChanged<String>? onPlainTextChanged;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final bool? willValidate;

  const PakiTextField({
    Key? key,
    this.name,
    required this.controller,
    this.isEnabled,
    this.showToolbar,
    this.removeHorizontalDiv,
    this.hint,
    this.minHeight,
    this.maxHeight,
    this.padding,
    this.onPlainTextChanged,
    this.validator,
    this.onSaved,
    this.willValidate,
  }) : super(key: key);

  @override
  State<PakiTextField> createState() => _PakiTextFieldState();
}

class _PakiTextFieldState extends State<PakiTextField> {
  bool get isEnabled => widget.isEnabled ?? true;
  bool get showToolbar => widget.showToolbar ?? true;
  bool get removeHorizontalDiv => widget.removeHorizontalDiv ?? false;
  bool get willValidate => widget.willValidate ?? true;
  FormFieldState<String>? _formFieldState;
  late final FocusNode _focusNode;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _scrollController = ScrollController();
    widget.controller.addListener(_handleControllerChanged);
  }

  @override
  void didUpdateWidget(covariant PakiTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_handleControllerChanged);
      widget.controller.addListener(_handleControllerChanged);
    }
  }

  @override
  void dispose() {
    _formFieldState = null;
    widget.controller.removeListener(_handleControllerChanged);
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  String get _plainText => widget.controller.document.toPlainText().trim();

  String? _defaultValidator(String? value) {
    if (_plainText.isEmpty && willValidate) {
      return 'Campo ${widget.name} obrigatório';
    }
    return null;
  }

  void _handleControllerChanged() {
    final text = _plainText;
    widget.onPlainTextChanged?.call(widget.controller.document.toPlainText());
    _formFieldState?.didChange(text);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    widget.controller.readOnly = !isEnabled;

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: Theme.of(context).dividerColor),
    );

    return FormField<String>(
      validator: widget.validator ?? _defaultValidator,
      onSaved: (_) => widget.onSaved?.call(_plainText),
      initialValue: _plainText,
      builder: (state) {
        _formFieldState = state;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            InputDecorator(
              decoration: InputDecoration(
                labelText: widget.name,
                hintText: widget.hint,
                enabled: isEnabled,
                errorText: state.errorText,
                border: border,
                enabledBorder: border,
                focusedBorder: border.copyWith(
                  borderSide: const BorderSide(color: pakiDefaultPrimaryColor),
                ),
                contentPadding: EdgeInsets.zero,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (showToolbar && isEnabled)
                    QuillSimpleToolbar(
                      controller: widget.controller,
                      config: const QuillSimpleToolbarConfig(
                        showHeaderStyle: false,
                        showCodeBlock: false,
                        showInlineCode: false,
                        showColorButton: false,
                        showBackgroundColorButton: false,
                        showClearFormat: false,
                        showListCheck: false,
                        showQuote: false,
                        showIndent: false,
                        showLink: false,
                        showSearchButton: false,
                        showSubscript: false,
                        showSuperscript: false,
                        showFontFamily: false,
                        showFontSize: false,
                      ),
                    ),
                  Container(
                    constraints: BoxConstraints(
                      minHeight: widget.minHeight ?? 160,
                      maxHeight: widget.maxHeight ?? 320,
                    ),
                    padding: widget.padding ?? const EdgeInsets.all(12),
                    child: QuillEditor.basic(
                      controller: widget.controller,
                      focusNode: _focusNode,
                      scrollController: _scrollController,
                      config: QuillEditorConfig(
                        placeholder: widget.hint,
                        scrollable: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (!removeHorizontalDiv) const PakiHorizontalDiv(),
          ],
        );
      },
    );
  }
}
