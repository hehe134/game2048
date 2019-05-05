import 'dart:math';

class Game2048 {
  final int row;
  final int column;
  int score=0;
  bool over = false;

  Game2048(this.row, this.column);

  List<List<int>> cells;

  void getScore() {
    int scoreN = 0;
    for (int r = 0; r < row; r++) {
      for (int c = 0; c < column; c++) {
        scoreN += cells[r][c];
      }
    }
    score = scoreN;
  }

  void newGame() {
    cells = List<List<int>>(column);
    for (int r = 0; r < column; r++) {
      List<int> list=new List<int>(row);
      for (int c = 0; c < row; c++) {
        list[c]= 0;
      }
      cells[r]=list;
    }
    getScore();
    randomCells(2);
    over=false;
  }

  void randomCells(int num) {
    print("RandomNum");
    List<Point> empty = new List<Point>();
    for (int r = 0; r < row; r++) {
      for (int c = 0; c < column; c++) {
        if (cells[r][c] == 0) empty.add(new Point(r, c));
      }
    }
    if (empty.isEmpty) {
      over = true;
      return;
    }
    Random r = Random();
    for (int i = 0; i < num; i++) {
      int index = r.nextInt(empty.length);
      cells[empty[index].x][empty[index].y] = randomNum();
      empty.removeAt(index);
    }
  }

  int randomNum() {
    final Random r = Random();
    return r.nextInt(3) == 0 ? 4 : 2;
  }

  void up() {
    print("up\n");
    List<int> full;
    int n = 0;
    for (int r = 0; r < row; r++) {
      full = new List<int>();
      for (int c = 0; c < column; c++) {
        n = cells[r][c];
        if (n != 0) {
          if (full.isNotEmpty && full.last == n)
            full.last *= 2;
          else
            full.add(n);
        }
      }
      int c = 0;
      for (; c < full.length; c++) {
        cells[r][c] = full[c];
      }
      for (; c < column; c++) {
        cells[r][c] = 0;
      }
    }
    randomCells(1);
    getScore();
  }

  void down() {
    print("down\n");
    List<int> full;
    int n = 0;
    for (int r = 0; r < row; r++) {
      full = new List<int>();
      for (int c = 0; c < column; c++) {
        n = cells[r][c];
        if (n != 0) {
          if (full.isNotEmpty && full.last == n)
            full.last *= 2;
          else
            full.add(n);
        }
      }
      int c = 0;
      for (; c < column - full.length; c++) {
        cells[r][c] = 0;
      }
      for (; c < column; c++) {
        cells[r][c] = full[c-(column - full.length)];
      }
    }
    randomCells(1);
    getScore();
  }

  void left() {
    print("left\n");
    List<int> full;
    int n = 0;
    for (int c = 0; c < column; c++) {
      full = new List<int>();
      for (int r = 0; r < row; r++) {
        n = cells[r][c];
        if (n != 0) {
          if (full.isNotEmpty && full.last == n)
            full.last *= 2;
          else
            full.add(n);
        }
      }
      int r = 0;
      for (; r < full.length; r++) {
        cells[r][c] = full[r];
      }
      for (; r < column; r++) {
        cells[r][c] = 0;
      }
    }
    randomCells(1);
    getScore();
  }

  void right() {
    print("right\n");
    List<int> full;
    int n = 0;
    for (int c = 0; c < column; c++) {
      full = new List<int>();
      for (int r = 0; r < row; r++) {
        n = cells[r][c];
        if (n != 0) {
          if (full.isNotEmpty && full.last == n)
            full.last *= 2;
          else
            full.add(n);
        }
      }
      int r = 0;
      for (; r < column - full.length; r++) {
        cells[r][c] = 0;
      }
      for (; r < column; r++) {
        cells[r][c] = full[r-(column - full.length)];
      }
    }
    randomCells(1);
    getScore();
  }


}

class Point {
  int x;
  int y;

  Point(int x, int y) {
    this.x = x;
    this.y = y;
  }
}
