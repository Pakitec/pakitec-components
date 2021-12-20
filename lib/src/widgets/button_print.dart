import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class PakiButtonPrint extends StatefulWidget {
  final Function() onTap;

  const PakiButtonPrint({Key? key, required this.onTap}) : super(key: key);

  @override
  _PakiButtonPrintState createState() => _PakiButtonPrintState();
}

class _PakiButtonPrintState extends State<PakiButtonPrint> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onTap,
        child: Container(
            height: 60,
            width: 60,
            padding: const EdgeInsets.only(left: 5.0),
            child: const RiveAnimation.asset('assets/animations/printer.riv', alignment: Alignment.center)));
  }
}
