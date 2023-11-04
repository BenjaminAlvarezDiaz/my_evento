import 'package:flutter/material.dart';

import 'my_tab_indicator.dart';

class MyPainter extends BoxPainter {
  final MyTabIndicator decoration;

  MyPainter(this.decoration, VoidCallback? onChanged) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final rect = offset & configuration.size!;

    // Define el color de fondo basado en la posición actual del indicador
    final color = Colors.orange; // Color dinámico

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawRect(rect, paint);
  }
}