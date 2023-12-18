import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:intl/intl.dart';

import '../styles/main_style.dart';
import 'divider.dart';

class PakiInputCalendar extends StatefulWidget {


  final String name;
  final TextEditingController controller;
  final bool? willValidate;
  final bool? isEnabled;
  final String? formatCalendar;
  final bool? isDate;
  final IconData? prefixIcon;
  final Widget? prefixWidget;
  final Function(DateTime? value) onChanged;

  const PakiInputCalendar({Key? key, required this.name, required this.controller, this.willValidate, this.isEnabled,
    this.formatCalendar, this.isDate, this.prefixIcon, this.prefixWidget, required this.onChanged}) : super(key: key);

  @override
  _PakiInputCalendarState createState() => _PakiInputCalendarState();
}

class _PakiInputCalendarState extends State<PakiInputCalendar> {
  bool willValidate = true;
  bool isEnabled = true;
  String formatCalendar = 'dd/MM/yyyy';
  bool isDate = true;

  @override
  void initState() {
    super.initState();
    if (widget.isDate != null) isDate = widget.isDate!;
    if (widget.isEnabled != null) isEnabled = widget.isEnabled!;
    if (widget.willValidate != null) willValidate = widget.willValidate!;
    if (widget.formatCalendar != null) formatCalendar = widget.formatCalendar!;
  }

  @override
  Widget build(BuildContext context) {

    final format = DateFormat(formatCalendar);
    return Column(children: <Widget>[
      DateTimeField(
        format: format,
        controller: widget.controller,
        enabled: isEnabled,
        textAlign: TextAlign.center,
        style: const TextStyle(color: primaryColor),
        onChanged: widget.onChanged,
        decoration: InputDecoration(
            labelText: widget.name,
            prefixIcon: widget.prefixWidget ?? (widget.prefixIcon != null ? Icon(widget.prefixIcon, color: Colors.white70): null),
            suffixIcon: IconButton(onPressed: (){}, icon: const Icon(FontAwesome5.calendar))
                ),
        onShowPicker: (context, dynamic currentValue) async {
          TimeOfDay? _time;
          DateTime? _date;
          isDate
              ? _date = (await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100),
              locale: const Locale('pt', 'BR')))!
              : _time = (await showTimePicker(initialTime: TimeOfDay.now(), context: context))!;
          return isDate ? _date : DateTimeField.convert(_time);
        },
      ),
      const PakiHorizontalDiv()
    ]);
  }
}
