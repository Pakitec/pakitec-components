import 'package:flutter/material.dart';

class PakiHorizontalDiv extends StatefulWidget {
  final double? value;
  const PakiHorizontalDiv({Key? key, this.value}) : super(key: key);

  @override
  _PakiHorizontalDivState createState() => _PakiHorizontalDivState();
}

class _PakiHorizontalDivState extends State<PakiHorizontalDiv> {
  double value = 20;

  @override
  void initState() {
    super.initState();
    if (widget.value != null) value = widget.value!;
  }

  @override
  Widget build(BuildContext context) {
    return Divider(height: value, color: Colors.transparent);
  }
}

class PakiVerticalDiv extends StatefulWidget {
  final double? value;
  const PakiVerticalDiv({Key? key, this.value}) : super(key: key);

  @override
  _PakiVerticalDivState createState() => _PakiVerticalDivState();
}

class _PakiVerticalDivState extends State<PakiVerticalDiv> {
  double value = 20;

  @override
  void initState() {
    super.initState();
    if (widget.value != null) value = widget.value!;
  }

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(width: value, color: Colors.transparent);
  }
}