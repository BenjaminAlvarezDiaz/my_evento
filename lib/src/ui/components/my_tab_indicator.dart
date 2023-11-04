import 'package:flutter/material.dart';
import 'my_painter.dart';

class MyTabIndicator extends Decoration {
  @override
  MyPainter createBoxPainter([VoidCallback? onChanged]) {
    return MyPainter(this, onChanged);
  }
}