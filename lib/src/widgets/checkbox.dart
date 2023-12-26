import 'package:flutter/material.dart';

class PakiCheckbox extends StatefulWidget {
  final String? label;
  final bool? selectedValue;
  final Function(bool? value) onChanged;

  const PakiCheckbox({Key? key, required this.label, required this.selectedValue, required this.onChanged})
      : super(key: key);

  @override
  State<PakiCheckbox> createState() => _PakiCheckboxState();
}

class _PakiCheckboxState extends State<PakiCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(5),
        child: Row(children: [
          widget.label != '' ? Text(widget.label!) : Container(),
          Checkbox(value: widget.selectedValue, onChanged: widget.onChanged)
        ]));
  }
}
