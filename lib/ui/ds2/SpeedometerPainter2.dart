import 'dart:math';
import 'package:flutter/material.dart';

class SpeedometerPainter2 extends CustomPainter {
  final double currentSpeed;
  final double maxSpeed = 12;
  final int numberOfTicks = 8;

  SpeedometerPainter2(this.currentSpeed);

  @override
  void paint(Canvas canvas, Size size) {
    _drawBackground(canvas, size);
    _drawMeter(canvas, size);
    _drawTicksAndLabels(canvas, size);
    _drawOverlappedLabels(canvas, size);
  }

  void _drawBackground(Canvas canvas, Size size) {
    final Paint BgPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, BgPaint);
  }

  void _drawMeter(Canvas canvas, Size size) {
    final double radius = size.height;

    final Paint meterPaint = Paint()
      ..shader = _createGradientShader(size)
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
  }

  Shader _createGradientShader(Size size) {
    //SweepGradient(
    //       colors: [Colors.lightGreenAccent, Colors.green],
    //       startAngle: 2 * pi * (180 / 360),
    //       endAngle: 2 * pi,
    //     )
    return RadialGradient(
      colors: [
        Colors.lightGreenAccent,
        Colors.green.withOpacity(0.6),
        Colors.black.withOpacity(0.1),
        Colors.transparent
      ],
      stops: [0.4, 0.5, 0.65, 1],
      center: Alignment.center,
      radius: 1.0,
    ).createShader(Rect.fromCircle(
      center: Offset(size.width / 2, size.height),
      radius: size.height - 50,
    ));
  }

  void _drawTicksAndLabels(Canvas canvas, Size size) {
    final double radius = size.height;
    final double tickLength = 30;
    final double startTickRadius = radius;
    final double endTickRadius = startTickRadius - tickLength;

    final Paint tickPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;

    final double progressEndAngle = -pi + pi * (currentSpeed / maxSpeed);

    for (int i = 0; i <= numberOfTicks; i++) {
      _drawTick(canvas, size, startTickRadius, endTickRadius, tickPaint, i);
      _drawLabel(
          canvas, size, endTickRadius, i, progressEndAngle, Colors.white);
    }
  }

  void _drawTick(Canvas canvas, Size size, double startTickRadius,
      double endTickRadius, Paint tickPaint, int i) {
    final double angle = -pi + (i / numberOfTicks) * pi;
    final double startX = size.width / 2 + startTickRadius * cos(angle);
    final double startY = size.height + startTickRadius * sin(angle);
    final double endX = size.width / 2 + endTickRadius * cos(angle);
    final double endY = size.height + endTickRadius * sin(angle);
    canvas.drawLine(Offset(startX, startY), Offset(endX, endY), tickPaint);
  }

  void _drawLabel(Canvas canvas, Size size, double endTickRadius, int i,
      double progressEndAngle, Color color) {
    final double angle = -pi + (i / numberOfTicks) * pi;
    final double labelRadius = endTickRadius - 30;

    final double labelX = size.width / 2 + labelRadius * cos(angle);
    final double labelY = size.height + labelRadius * sin(angle);

    final textPainter = _createTextPainter(i, color);
    textPainter.paint(
      canvas,
      Offset(labelX - textPainter.width / 2, labelY - textPainter.height / 2),
    );
  }

  TextPainter _createTextPainter(int i, Color color) {
    return TextPainter(
      text: TextSpan(
        text: '${(i * (maxSpeed / numberOfTicks)).toInt()}',
        style: TextStyle(
          color: color,
          fontSize: 30.0,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
  }

  void _drawOverlappedLabels(Canvas canvas, Size size) {
    canvas.save();
    _applyArcClip(canvas, size);

    final double radius = size.height;
    final double tickLength = 30;
    final double startTickRadius = radius;
    final double endTickRadius = startTickRadius - tickLength;

    final double progressEndAngle = -pi + pi * (currentSpeed / maxSpeed);

    for (int i = 0; i <= numberOfTicks; i++) {
      _drawLabel(
          canvas, size, endTickRadius, i, progressEndAngle, Colors.black);
    }
    canvas.restore(); //回復canvas的上次狀態(包含座標、clip之類的)
  }

  void _applyArcClip(Canvas canvas, Size size) {
    final double radius = size.height;
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
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
