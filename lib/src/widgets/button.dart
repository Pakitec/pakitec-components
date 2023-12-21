import 'package:flutter/material.dart';

import '../styles/main_style.dart';
import 'divider.dart';

class PakiButton extends StatefulWidget {
  final IconData iconData;
  final String text;
  final Function() onPressed;
  final double? width;
  final double? height;


  const PakiButton({Key? key, required this.iconData, required this.text, required this.onPressed, this.width,
    this.height}) : super(key: key);

  @override
  State<PakiButton> createState() => _PakiButtonState();
}

class _PakiButtonState extends State<PakiButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.width != null ? widget.width! : 150,
        height: widget.height != null ? widget.height! : 50,
        child: ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(buttonColor)),
            onPressed: widget.onPressed,
            child: Row(
              children: [
                Icon(widget.iconData),
                const PakiVerticalDiv(width: 7.5),
                Text(
                  widget.text,
                  style: const TextStyle(fontSize: 11.0),
                  textAlign: TextAlign.justify,
                )
              ]
            )));
  }
}
