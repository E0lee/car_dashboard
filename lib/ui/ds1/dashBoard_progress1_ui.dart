import 'package:car_dashboard/ui/ds1/progressMarker.dart';
import 'package:flutter/material.dart';

class dashBoard_progress1_ui extends StatelessWidget {
  const dashBoard_progress1_ui({
    super.key,
    this.startAngle = 0,
    this.endAngle = 360,
    required this.radius,
  });

  final double radius;
  final double startAngle;
  final double endAngle;

  @override
  Widget build(BuildContext context) {
    List<int> textMarker = [0, 4, 6, 8, 10, 12, 14, 16];
    return Stack(
      children: [
        for (var i = 0; i < 70; i++)
          Positioned(
            left: radius,
            top: radius,
            child: progressMarker(
              angle: i * ((endAngle - startAngle) / 70.0) + startAngle,
              radius: radius,
              marker: Container(width: 2, height: 5, color: Colors.grey[500]),
            ),
          ),
        for (var i = 0; i < 14; i++)
          Positioned(
            left: radius,
            top: radius,
            child: progressMarker(
              angle: i * ((endAngle - startAngle) / 14.0) + startAngle,
              radius: radius,
              marker: Container(width: 4, height: 12, color: Colors.grey[500]),
            ),
          ),
        for (var i = 0; i < 8; i++)
          Positioned(
            left: radius,
            top: radius,
            child: progressMarker(
              angle: i * ((endAngle - startAngle) / 7.0) + startAngle,
              radius: radius,
              marker: Container(width: 6, height: 12, color: Colors.grey[700]),
            ),
          ),
        for (var i = 0; i < 8; i++)
          Positioned(
            left: radius,
            top: radius,
            child: progressTextMarker(
              angle: i * ((endAngle - startAngle) / 7.0) + startAngle,
              radius: radius,
              value: textMarker[i],
              maxAngel: 360,
            ),
          ),
      ],
    );
  }
}
