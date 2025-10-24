import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../../pakitec_components.dart';

class PakiColorPicker extends StatefulWidget {
  final TextEditingController controller;
  final String currentColor;
  final Function(String) onChanged;

  const PakiColorPicker({Key? key,
    required this.controller,
    required this.currentColor,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<PakiColorPicker> createState() => _ColorPickerFieldState();
}

class _ColorPickerFieldState extends State<PakiColorPicker> {

  late Color actualColor;
  @override
  void initState() {
    super.initState();
    actualColor = _parseColor(widget.currentColor);
  }

  void openColorPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Selecione uma cor'),
        content: SingleChildScrollView(
          child: ColorPicker(
            enableAlpha: false,
            pickerColor: actualColor,
            onColorChanged: (color) {
              setState(() => actualColor = color);
              // ignore: deprecated_member_use
              final hexColor = '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
              widget.controller.text = hexColor;
              widget.onChanged(hexColor);
            },
          ),
        ),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      InkWell(
        onTap: openColorPicker,
        child: IgnorePointer(
          ignoring: true,
          child: TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              labelText: 'Cor',
              prefixIcon: Container(
                width: 20,
                height: 20,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: actualColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade300),
                ),
              ),
            ),
          ),
        ),
      ),
      const PakiHorizontalDiv()
    ]);
  }

  Color _parseColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor'; // adiciona opacidade total se não tiver alpha
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}
