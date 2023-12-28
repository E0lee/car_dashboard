import 'dart:math';

import 'package:flutter/material.dart';

class progressMarker extends StatelessWidget {
  const progressMarker({
    super.key,
    required this.angle,
    required this.radius,
    required this.marker,
  });
  final double angle;
  final double radius;
  final Container marker;

  @override
  Widget build(BuildContext context) {
    double width = marker.constraints!.maxWidth!;
    double height = marker.constraints!.maxHeight!;

    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..translate(-width / 2, -height / 2, 0.0) // center to origin
        ..rotateZ(2 * pi * (angle / 360))
        ..translate(0.0, radius - height / 2, 0.0),
      child: marker,
    );
  }
}

class progressTextMarker extends StatelessWidget {
  const progressTextMarker({
    Key? key,
    required this.angle,
    required this.value,
    required this.maxAngel,
    required this.radius,
    this.color = Colors.black,
  }) : super(key: key);

  final double angle;
  final int value;
  final int maxAngel;
  final double radius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    const width = 40.0;
    const height = 30.0;
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..translate(-width / 2, -height / 2, 0.0)
        ..rotateZ(2 * pi * (angle / maxAngel))
        ..translate(0.0, radius - 30, 0.0)
        ..rotateZ(-2 * pi * (angle / maxAngel)),
      child: SizedBox(
        width: width,
        height: height,
        child: Text(
          value.toString(),
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
