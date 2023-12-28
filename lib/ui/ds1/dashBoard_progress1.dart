import 'dart:math';

import 'package:flutter/material.dart';

class dashBoard_progress1 extends StatefulWidget {
  dashBoard_progress1({
    super.key,
    this.startAngle = 0,
    this.endAngle = 360,
    required this.value,
    required this.radius,
    this.maxValue = 220,
    this.centerColor = Colors.black,
    this.dashColor = const [Colors.lightGreenAccent, Colors.green],
  });
  final double startAngle;
  final double endAngle;
  final double value;
  final double radius;
  final double maxValue;
  final Color centerColor;
  final List<Color> dashColor;

  @override
  State<dashBoard_progress1> createState() => _dashBoard_progress1State();
}

class _dashBoard_progress1State extends State<dashBoard_progress1>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _controller.value = widget.value / widget.maxValue;
  }

  @override
  void didUpdateWidget(dashBoard_progress1 oldWidget) {
    super.didUpdateWidget(oldWidget);
    print(widget.value);
    if (oldWidget.value != widget.value) {
      _controller.value = widget.value / widget.maxValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      //先畫一個圓形
      alignment: Alignment.center,
      children: [
        Transform.rotate(
          angle: pi * 0.5,
          child: Container(
            width: widget.radius * 2,
            height: widget.radius * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                tileMode: TileMode.decal,
                colors: widget.dashColor,
                stops: [0.0, 1],
                startAngle: 2 * pi * (widget.startAngle / 360),
                endAngle: 2 *
                        pi *
                        ((widget.startAngle / 360) +
                            _controller.value *
                                ((widget.endAngle - widget.startAngle) / 360)) +
                    0.0001, //防止開始角度等於結束角度//value最高值只能0.5
              ),
            ),
          ),
        ),
        ClipOval(
          child: Container(
            width: widget.radius,
            height: widget.radius,
            color: widget.centerColor,
          ),
        ),
        Text(
          (_controller.value * widget.maxValue).floor().toString(),
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
