import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pakitec_themes/pakitec_themes.dart';
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
  final DatePickerEntryMode? datePickerEntryMode;
  final Function(DateTime? value) onChanged;

  const PakiInputCalendar(
      {Key? key,
      required this.name,
      required this.controller,
      this.willValidate,
      this.isEnabled,
      this.formatCalendar,
      this.isDate,
      this.prefixIcon,
      this.prefixWidget,
      this.datePickerEntryMode,
      required this.onChanged})
      : super(key: key);

  @override
  State<PakiInputCalendar> createState() => _PakiInputCalendarState();
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

    if (!isDate && formatCalendar == 'dd/MM/yyyy') {
      formatCalendar = 'HH:mm';
    }
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
          style: const TextStyle(color: pakiDefaultPrimaryColor),
          onChanged: widget.onChanged,
          decoration: InputDecoration(
              labelText: widget.name,
              prefixIcon: widget.prefixWidget ??
                  (widget.prefixIcon != null ? Icon(widget.prefixIcon, color: Colors.white70) : null),
              suffixIcon: const Icon(Icons.calendar_month)),
          onShowPicker: (context, dynamic currentValue) async {
            TimeOfDay? dTime;
            DateTime? dDate;
            isDate
                ? dDate = (await showDatePicker(
                    context: context,
                    initialEntryMode: widget.datePickerEntryMode ?? DatePickerEntryMode.calendar,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100),
                    locale: const Locale('pt', 'BR')))!
                : dTime = (await showTimePicker(initialTime: TimeOfDay.now(), context: context))!;
            return isDate ? dDate : DateTimeField.convert(dTime);
          }),
      const PakiHorizontalDiv()
    ]);
  }
}
