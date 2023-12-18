import 'package:flutter/material.dart';

class PakiHorizontalDiv extends StatefulWidget {
  final double? height;
  const PakiHorizontalDiv({Key? key, this.height}) : super(key: key);

  @override
  _PakiHorizontalDivState createState() => _PakiHorizontalDivState();
}

class _PakiHorizontalDivState extends State<PakiHorizontalDiv> {
  double height = 20;

  @override
  void initState() {
    super.initState();
    if (widget.height != null) {height = widget.height!;}
  }

  @override
  Widget build(BuildContext context) {
    return Divider(height: height, color: Colors.transparent);
  }
}

class PakiVerticalDiv extends StatefulWidget {
  final double? width;
  const PakiVerticalDiv({Key? key, this.width}) : super(key: key);

  @override
  _PakiVerticalDivState createState() => _PakiVerticalDivState();
}

class _PakiVerticalDivState extends State<PakiVerticalDiv> {
  double width = 20;

  @override
  void initState() {
    super.initState();
    if (widget.width != null) {width = widget.width!;}
  }

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(width: width, color: Colors.transparent);
  }
}