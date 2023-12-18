import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class PakiCompassIndicator extends StatefulWidget {
  const PakiCompassIndicator({Key? key}) : super(key: key);


  @override
  _PakiCompassIndicatorState createState() => _PakiCompassIndicatorState();
}

class _PakiCompassIndicatorState extends State<PakiCompassIndicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 30,
        width: 30,
        padding: const EdgeInsets.only(left: 5.0),
        child: const RiveAnimation.asset('assets/animations/compass.riv', alignment: Alignment.center)
    );
  }
}
