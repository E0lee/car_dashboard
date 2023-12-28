import 'dart:math';

import 'package:flutter/material.dart';

class SpeedometerPainter extends CustomPainter {
  final double currentSpeed;
  final double maxSpeed = 12;
  final int numberOfTicks = 8;

  SpeedometerPainter(this.currentSpeed);

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.height;
    final double tickLength = 30;
    final double startTickRadius = radius; // Adjust this value as needed
    final double endTickRadius = startTickRadius - tickLength;

    final Paint tickPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;

    final Paint BgPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, BgPaint);

    final Paint meterPaint = Paint()
      ..shader = const SweepGradient(
        colors: [Colors.lightGreenAccent, Colors.green],
        startAngle: 2 * pi * (180 / 360),
        endAngle: 2 * pi,
      ).createShader(Rect.fromCircle(
        center: Offset(size.width / 2, size.height),
        radius: size.height - 50,
      ))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 100;

    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width / 2, size.height), radius: radius - 50),
      -pi,
      pi * (currentSpeed / maxSpeed),
      false,
      meterPaint,
    );

    final double progressEndAngle = -pi + pi * (currentSpeed / maxSpeed);

    for (int i = 0; i <= numberOfTicks; i++) {
      final double angle = -pi + (i / numberOfTicks) * pi;
      final double startX = size.width / 2 + startTickRadius * cos(angle);
      final double startY = size.height + startTickRadius * sin(angle);
      final double endX = size.width / 2 + endTickRadius * cos(angle);
      final double endY = size.height + endTickRadius * sin(angle);
      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), tickPaint);

      final double labelRadius =
          endTickRadius - 30; // Adjust this value as needed

      final double labelX = size.width / 2 + labelRadius * cos(angle);
      final double labelY = size.height + labelRadius * sin(angle);

      final textPainter = TextPainter(
        text: TextSpan(
          text: '${(i * (maxSpeed / numberOfTicks)).toInt()}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0, // Adjust font size if needed
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();

      textPainter.paint(
        canvas,
        Offset(labelX - textPainter.width / 2, labelY - textPainter.height / 2),
      );

      if (angle <= progressEndAngle) {
        //
        canvas.save();
        canvas.clipPath(
          Path()
            ..moveTo(size.width / 2, size.height)
            ..lineTo(size.width / 2 + (radius) * cos(-pi),
                size.height + (radius) * sin(-pi))
            ..arcTo(
                Rect.fromCircle(
                  center: Offset(size.width / 2, size.height),
                  radius: radius,
                ),
                -pi,
                pi * (currentSpeed / maxSpeed),
                false),
        );

        final textPainterBlack = TextPainter(
          text: TextSpan(
            text: '${(i * (maxSpeed / numberOfTicks)).toInt()}',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 30.0,
            ),
          ),
          textDirection: TextDirection.ltr,
        );

        textPainterBlack.layout();
        textPainterBlack.paint(
          canvas,
          Offset(labelX - textPainterBlack.width / 2,
              labelY - textPainterBlack.height / 2),
        );

        canvas.restore();
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
