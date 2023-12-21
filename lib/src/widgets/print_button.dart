import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class PakiPrintButton extends StatefulWidget {
  final Function() onTap;

  const PakiPrintButton({Key? key, required this.onTap}) : super(key: key);

  @override
  State<PakiPrintButton> createState() => _PakiPrintButtonState();
}

class _PakiPrintButtonState extends State<PakiPrintButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.onTap,
        child: Container(
            height: 60,
            width: 60,
            padding: const EdgeInsets.only(left: 5.0),
            child: const RiveAnimation.asset('assets/animations/printer.riv', alignment: Alignment.center)));
  }
}
