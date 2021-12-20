import 'package:flutter/material.dart';
import 'package:pakitec_components/pakitec_components.dart';

class PakiButton extends StatefulWidget {
  final IconData iconData;
  final String text;
  final Function() onPressed;
  final double? width;
  final double? height;
  final Color? color;


  const PakiButton({Key? key, required this.iconData, required this.text, required this.onPressed, this.width,
    this.height, this.color}) : super(key: key);

  @override
  _PakiButtonState createState() => _PakiButtonState();
}

class _PakiButtonState extends State<PakiButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.width != null ? widget.width! : 150,
        height: widget.height != null ? widget.height! : 50,
        child: ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(widget.color)),
            onPressed: widget.onPressed,
            child: Row(
              children: [
                Icon(widget.iconData),
                const PakiVerticalDiv(value: 7.5),
                Text(
                  widget.text,
                  style: const TextStyle(fontSize: 11.0),
                  textAlign: TextAlign.center,
                )
              ],
            )));
  }
}
