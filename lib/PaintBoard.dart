import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class PaintBoard extends CustomPainter {
  final List<List<int>> cells;
  final Size screenSize;
  final double titlePadding;

  PaintBoard(this.cells, this.screenSize, this.titlePadding);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final rows = cells.length;
    final columns = cells[0].length;
    final height = (screenSize.height - titlePadding) * 0.7;
    final pos_X = screenSize.width / columns / 2;
    final pos_Y = height / rows / 2;

    double eWidth = size.width / rows;
    double eHeight = size.height / columns;
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = Colors.black26;
    canvas.drawRect(Offset.zero & size, paint);

    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.black87
      ..strokeWidth = 1.0;
    for (int i = 0; i <= columns; ++i) {
      double dy = eHeight * i;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }

    for (int i = 0; i <= rows; ++i) {
      double dx = eWidth * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}