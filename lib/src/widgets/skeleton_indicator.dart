import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';

class PakiSkeletonIndicator extends StatelessWidget {
  const PakiSkeletonIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              color: Colors.transparent,
              child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: const Center(child: Icon(Icons.photo, size: 55)),
                        ),
                        const VerticalDivider(width: 5.0),
                        const Expanded(child: PlaceholderLines(animate: true, color: Colors.grey, count: 3))
                      ]))));
        });
  }
}
