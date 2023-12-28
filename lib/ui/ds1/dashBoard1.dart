import 'package:car_dashboard/ui/ds1/progressMarker.dart';
import 'package:flutter/material.dart';

import 'dashBoard_progress1.dart';
import 'dashBoard_progress1_ui.dart';

class dashBoard1 extends StatefulWidget {
  const dashBoard1({
    super.key,
    required this.value,
    required this.radius,
  });
  final double value;
  final double radius;

  @override
  State<dashBoard1> createState() => _dashBoard1State();
}

class _dashBoard1State extends State<dashBoard1> {
  @override
  Widget build(BuildContext context) {
    List<int> textMarker = [0, 4, 6, 8, 10, 12, 14, 16];
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          for (var i = 0; i < 8; i++)
            Positioned(
              left: widget.radius,
              top: widget.radius,
              child: progressTextMarker(
                color: Colors.white,
                angle: i * ((270 - 30) / 7.0) + 30,
                radius: widget.radius,
                value: textMarker[i],
                maxAngel: 360,
              ),
            ),
          dashBoard_progress1(
            radius: widget.radius,
            value: widget.value,
            startAngle: 60,
            endAngle: 300,
            maxValue: 18,
          ),
          dashBoard_progress1_ui(
            radius: widget.radius,
            startAngle: 60,
            endAngle: 270,
          ),
        ],
      ),
    );
  }
}
