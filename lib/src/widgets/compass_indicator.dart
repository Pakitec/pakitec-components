import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class CompassIndicator extends StatefulWidget {
  const CompassIndicator({Key? key}) : super(key: key);


  @override
  _CompassIndicatorState createState() => _CompassIndicatorState();
}

class _CompassIndicatorState extends State<CompassIndicator> {
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
