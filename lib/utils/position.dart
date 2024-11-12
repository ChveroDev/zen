import 'package:flutter/material.dart';

class Position {
  late double dx;
  late double dy;

  Position({this.dx = 0, this.dy = 0});

  Position.fromOffset(Offset offset) {
    dx = offset.dx;
    dy = offset.dy;
  }
}
