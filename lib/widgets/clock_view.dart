import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  final double size;
  const ClockView({super.key, required this.size});

  @override
  State<ClockView> createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(
        () {},
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();

  //60sec - 360deg, 1 sec - 6deg
  //12hour - 360deg, 1 hour - 30 deg

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var fillBrush = Paint();
    fillBrush.color = const Color(0xFF444974);

    var outlineBrush = Paint()
      ..color = const Color(0xFFEAECFF)
      ..strokeWidth = size.width / 30
      ..style = PaintingStyle.stroke;

    var centerDot = Paint()
      ..color = const Color(0xFFEAECFF)
      ..style = PaintingStyle.fill;

    var dashBrush = Paint()
      ..color = const Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    var secondsHandBrush = Paint()
      ..color = Colors.orange[300]!
      ..strokeWidth = size.width / 60
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    var minutesHandBrush = Paint()
      ..shader = const RadialGradient(colors: [
        Colors.lightBlue,
        Colors.pink,
      ]).createShader(
        Rect.fromCircle(center: center, radius: radius),
      )
      ..strokeWidth = size.width / 30
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    var hoursHandBrush = Paint()
      ..shader = const RadialGradient(colors: [
        Colors.lightBlue,
        Colors.pink,
      ]).createShader(
        Rect.fromCircle(center: center, radius: radius),
      )
      ..strokeWidth = size.width / 24
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius * 0.75, fillBrush);
    canvas.drawCircle(center, radius * 0.75, outlineBrush);

    var hourHandX = centerX +
        (radius * 0.35) *
            cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerX +
        (radius * 0.35) *
            sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hoursHandBrush);

    var minHandX =
        centerX + (radius * 0.5) * cos((dateTime.minute * 6) * pi / 180);
    var minHandY =
        centerX + (radius * 0.5) * sin((dateTime.minute * 6) * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minutesHandBrush);

    var secHandX =
        centerX + (radius * 0.65) * cos((dateTime.second * 6) * pi / 180);
    var secHandY =
        centerX + (radius * 0.65) * sin((dateTime.second * 6) * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secondsHandBrush);

    canvas.drawCircle(center, radius * 0.075, centerDot);

    var outerCircleRadius = radius;
    var innerCircleRadius = radius * 0.9;
    for (var i = 0; i < 360; i += 12) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerX + outerCircleRadius * sin(i * pi / 180);

      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerX + innerCircleRadius * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
