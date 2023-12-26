import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:pakitec_themes/pakitec_themes.dart';


class PakiAddButton extends StatefulWidget {
  final Function() onPressed;

  const PakiAddButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<PakiAddButton> createState() => _PakiAddButtonState();
}

class _PakiAddButtonState extends State<PakiAddButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: widget.onPressed, backgroundColor: pakiDefaultButtonColor, child: const Icon(FontAwesome5.plus, color: Colors.white));
  }
}
