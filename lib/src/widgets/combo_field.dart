import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../pakitec_components.dart';

class PakiComboField extends StatefulWidget {
  final String label;
  final List<String> list;
  final bool? showSearchBox;
  final String? selectedValue;
  final bool? removeHorizontalDiv;
  final void Function(String? value) onSelect;

  const PakiComboField(
      {Key? key,
      required this.label,
      required this.list,
      required this.onSelect,
      this.showSearchBox,
      this.selectedValue,
      this.removeHorizontalDiv})
      : super(key: key);

  @override
  _PakiComboFieldState createState() => _PakiComboFieldState();
}

class _PakiComboFieldState extends State<PakiComboField> {
  late bool showSearchBox;
  bool removeHorizontalDiv = false;

  @override
  void initState() {
    super.initState();
    showSearchBox = widget.showSearchBox ?? false;
    if (widget.removeHorizontalDiv != null) removeHorizontalDiv = widget.removeHorizontalDiv!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DropdownSearch<String>(
          mode: Mode.MENU,
          showSelectedItems: true,
          showSearchBox: showSearchBox,
          items: widget.list,
          // ignore: deprecated_member_use
          //label: widget.label,
          dropdownSearchTextAlign: TextAlign.center,
          selectedItem: widget.selectedValue,
          onChanged: widget.onSelect),
      removeHorizontalDiv ? Container() : const PakiHorizontalDiv()
    ]);
  }
}
