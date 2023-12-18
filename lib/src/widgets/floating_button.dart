import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import '../styles/main_style.dart';


class PakiAddButton extends StatefulWidget {
  final Function() onPressed;

  const PakiAddButton(this.onPressed, {Key? key}) : super(key: key);

  @override
  _PakiAddButtonState createState() => _PakiAddButtonState();
}

class _PakiAddButtonState extends State<PakiAddButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: widget.onPressed, backgroundColor: buttonColor, child: const Icon(FontAwesome5.plus, color: Colors.white));
  }
}
