import 'package:flutter/material.dart';

class PakiEditListView extends StatelessWidget {
  final List<Widget> children;
  const PakiEditListView({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(margin: const EdgeInsets.all(10.0), child: ListView(padding: const EdgeInsets.only(top: 10.0), children: children));
  }
}
