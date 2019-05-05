import 'package:flutter/material.dart';
import 'package:game2048/Paint.dart';
import 'package:game2048/PaintBoard.dart';
import 'package:game2048/game.dart';

void main() => runApp(MyApp());

Game2048 myGame;
double titlePadding;
Size screenSize;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2048',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
          body: Column(
        children: <Widget>[
          Game(),
        ],
      )),
    );
  }
}

class Game extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Game();
  }
}

class _Game extends State<Game> {
  final int row = 4;
  final int column = 4;
  bool begin = false;
  bool dragging = false;

  @override
  void initState() {
    print("initstate");
    //   super.initState();
    myGame = Game2048(row, column);
    newGame();
  }

  void newGame() {
    print("newGame");
    myGame.newGame();
    setState(() {});
  }

  void moveUp() {
    print("moveup");
    setState(() {
      myGame.up();
    });
  }

  void moveDown() {
    print("movedown");
    setState(() {
      myGame.down();
    });
  }

  void moveLeft() {
    print("moveleft");

    setState(() {
      myGame.left();
    });
  }

  void moveRight() {
    print("moveright");

    setState(() {
      myGame.right();
    });
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets _gameMargin = EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0);
    final data = MediaQuery.of(context);
    final Size screenSize = data.size;
    final double titlePadding = data.padding.top;
    final double realHeight = (screenSize.width - titlePadding) * 0.7;
    final Size basicSize = Size(screenSize.width, realHeight);
    if (begin == false) {
      initState();
      begin = true;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10, right: 13),
                alignment: Alignment.center,
                width: 80.0,
                height: 40.0,
                child: Column(
                  children: <Widget>[
                    Text("Score"),
                    Text(
                      myGame.score.toString(),
                      style: TextStyle(color: Colors.red),
                    )
                    //总分
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
              ),
              FlatButton(
                child: Container(
                  margin: EdgeInsets.only(left: 25),
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 5.0),
                  width: 80.0,
                  height: 40.0,
                  child: Text("new Game"),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                ),
                onPressed: () {
                  newGame();
                },
              ),
            ],
          ),
        ),
        Container(
          height: 50.0,
          child: Opacity(
            opacity: myGame.over ? 1.0 : 0.0,
            child: Center(
              child: Text(
                "Game Over",
                style: TextStyle(fontSize: 26.0),
              ),
            ),
          ),
        ),

        Container(
          alignment: Alignment.center,
          height: screenSize.width,
          child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: CustomPaint(
                  size: Size(300, 300),
                  foregroundPainter:
                      Painter(myGame.cells, Size(300, 300), titlePadding),
                  child: CustomPaint(
                    size: Size(300, 300),
                    foregroundPainter:
                        PaintBoard(myGame.cells, screenSize, titlePadding),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: _gameMargin,
                width: screenSize.width,
                height: screenSize.width,
                child: GestureDetector(
                  onVerticalDragUpdate: (detail) {
//                    print("Vertical");
                    if (detail.delta.distance == 0 || dragging) {
                      return;
                    }
                    dragging = true;
                    if (detail.delta.direction> 0) {
                      moveDown();
                    } else
                      moveUp();
                  },
                  onVerticalDragEnd: (detail) {
                    dragging = false;
                  },
                  onVerticalDragCancel: () {
                    dragging = false;
                  },
                  onHorizontalDragUpdate: (detail) {
//                    print("Horizon");
                    if (detail.delta.distance == 0 || dragging) {
                      return;
                    } else {
                      dragging = true;
                      if (detail.delta.direction > 0)
                        moveLeft();
                      else
                        moveRight();
                    }
                  },
                  onHorizontalDragDown: (detail) {
                    dragging = false;
                  },
                  onHorizontalDragCancel: () {
                    dragging = false;
                  },
                ),
              ),
            ],
          ),
        ),


      ],
    );
  }
}

