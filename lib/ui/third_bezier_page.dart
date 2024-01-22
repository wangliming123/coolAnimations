import 'dart:math';

import 'package:flutter/material.dart';

///三阶贝塞尔曲线动画
class ThirdBezierPage extends StatefulWidget {
  const ThirdBezierPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CoolAnim1State();
  }
}

class _CoolAnim1State extends State<ThirdBezierPage>
    with SingleTickerProviderStateMixin {
  late final controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 3));
  double angleDiff = pi / 6;
  double radiusXPercent = 3 / 4;
  double radiusYPercent = 3 / 8;

  @override
  void initState() {
    super.initState();

    final radiusXAnim = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 3 / 4, end: 3 / 8), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 3 / 8, end: 3 / 4), weight: 1),
    ]).animate(controller);
    radiusXAnim.addListener(() {
      setState(() {
        radiusXPercent = radiusXAnim.value;
      });
    });

    final radiusYAnim = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 3 / 8, end: 3 / 4), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 3 / 4, end: 3 / 8), weight: 1),
    ]).animate(controller);
    radiusYAnim.addListener(() {
      setState(() {
        radiusYPercent = radiusYAnim.value;
      });
    });

    final angleDiffAnim = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: pi / 9, end: pi / 3), weight: 1),
      TweenSequenceItem(tween: Tween(begin: pi / 3, end: pi / 9), weight: 1),
    ]).animate(controller);
    angleDiffAnim.addListener(() {
      setState(() {
        angleDiff = angleDiffAnim.value;
      });
    });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: CoolAnim1Painter(
          count: 120,
          angleDiff: angleDiff,
          radiusXPercent: radiusXPercent,
          radiusYPercent: radiusYPercent,
        ),
      ),
    );
  }
}

class CoolAnim1Painter extends CustomPainter {
  final int count;
  final double angleDiff;

  final double radiusXPercent;
  final double radiusYPercent;

  CoolAnim1Painter({
    required this.count,
    this.angleDiff = pi / 6,
    this.radiusXPercent = 3 / 4,
    this.radiusYPercent = 2 / 3,
  });

  final linePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1
    // ..color = Colors.blue
    ..isAntiAlias = true;
  final pointPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3
    ..color = Colors.black
    ..isAntiAlias = true;

  late final eachAngle = (2 * pi / count);
  late final List<Path> pathList = List.generate(count, (index) => Path());

  // final List<Offset> pointList = [];

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final centerX = width / 2;
    final centerY = height / 2;
    linePaint.shader = const LinearGradient(
      colors: [Color(0xff0055ff), Color(0xff43b988)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).createShader(Rect.fromCenter(
        center: Offset(centerX, centerY), width: min(width, height), height: min(width, height)));

    generatePathList(centerX, centerY);
    for (var path in pathList) {
      canvas.drawPath(path, linePaint);
    }

    // canvas.drawPoints(PointMode.points, pointList, pointPaint);
  }

  double pointX(double radius, double centerX, double radians) {
    return centerX + cos(radians) * radius;
  }

  double pointY(double radius, double centerY, double radians) {
    return centerY + sin(radians) * radius;
  }

  void generatePathList(double centerX, double centerY) {
    final radiusX = min(centerX, centerY) * radiusXPercent;
    final radiusY = min(centerX, centerY) * radiusYPercent;
    // pointList.clear();
    for (int i = 0; i < count; i++) {
      final path = pathList[i];
      path.reset();
      path.moveTo(centerX, centerY);
      // pointList.add(Offset(centerX, centerY));
      path.cubicTo(
        pointX(radiusX, centerX, i * eachAngle),
        pointY(radiusY, centerY, i * eachAngle),
        pointX(radiusX, centerX, i * eachAngle + angleDiff * 1),
        pointY(radiusY, centerY, i * eachAngle + angleDiff / 2),
        pointX(radiusX, centerX, i * eachAngle + angleDiff / 2),
        pointY(radiusY, centerY, i * eachAngle + angleDiff * 2),
      );

      // pointList.add(Offset(pointX(radiusX, centerX, i * eachAngle),
      //     pointY(radiusY, centerY, i * eachAngle)));
      // pointList.add(Offset(
      //     pointX(radiusX, centerX, i * eachAngle + angleDiff * 1),
      //     pointY(radiusY, centerY, i * eachAngle + angleDiff * 1)));
      // pointList.add(Offset(
      //     pointX(radiusX, centerX, i * eachAngle + angleDiff * 2),
      //     pointY(radiusY, centerY, i * eachAngle + angleDiff * 2)));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
