import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  final Offset widget1Position;
  final Offset widget2Position;

  LinePainter(this.widget1Position, this.widget2Position);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // Draw a line from the center of Widget 1 to the center of Widget 2
    canvas.drawLine(
      widget1Position.translate(
          80, -30), // Translate to the center of the first widget
      widget2Position.translate(
          10, -30), // Translate to the center of the second widget
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
