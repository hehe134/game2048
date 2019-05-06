import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

final Map<int, Color> BoxColors = <int, Color>{
  2: Colors.orange[50],
  4: Colors.orange[100],
  8: Colors.orange[200],
  16: Colors.orange[300],
  32: Colors.orange[400],
  64: Colors.orange[500],
  128: Colors.orange[600],
  256: Colors.orange[700],
  512: Colors.orange[800],
  1024: Colors.orange[900],
  2048: Colors.red,
  4096: Colors.red[700],
  8192: Colors.red[800],
};

class Painter extends CustomPainter {
  final List<List<int>> cells;
  final Size screenSize;
  final double titlePadding;

  Painter(this.cells, this.screenSize, this.titlePadding);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    final rows = cells.length;
    final columns = cells[0].length;
    final height = (screenSize.height);
    final pos_X = screenSize.width / columns / 2;
    final pos_Y = height / rows / 2;
    Paint paint = Paint();
    paint.strokeWidth = 1;
    TextSpan span;
    TextPainter tp;
    String nums;
    for (int i = 0; i < rows; i += 1) {
      for (int j = 0; j < columns; j += 1) {
        int num = cells[i][j];
        nums = num.toString();
        print(num);
        paint.color = BoxColors.containsKey(num)
            ? BoxColors[num]
            : BoxColors[BoxColors.keys.last];
        if (num > 0) {
          canvas.drawCircle(
              Offset(pos_X + pos_X * 2 * i, pos_Y + pos_Y * 2 * j), 30, paint);
          span = new TextSpan(
              style: new TextStyle(
                color: Colors.black54,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              text: nums);
          tp = new TextPainter(
              text: span,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl);
          tp.layout();
          tp.paint(
            canvas,
            new Offset(pos_X - 20 * nums.length * 0.3 + pos_X * 2 * i,
                pos_Y - 14 + pos_Y * 2 * j),
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

  bool shouldRebuildSemantics(Painter oldDelegate) => true;
}
