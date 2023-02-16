import 'package:flutter/material.dart';
import 'dart:math' as math;

enum PlayerState {
  playerX,
  playerY,
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GameBoard(),
    );
  }
}

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  static PlayerState player = PlayerState.playerX;
  List<double> winCrossPositionsX = [320, 190, 60];
  List<double> winCrossPositionsY = [130, 8, -130];
  List<double> winCrossRotations = [0.5, 4, -4, 2];
  double winCrossPosX = 320;
  double winCrossPosY = 0;
  double winCrossRot = 0.5;
  List<Color> winCrossColor = [
    Colors.transparent,
    const Color.fromARGB(255, 249, 209, 83)
  ];
  List<int> winCrossAlpha = [0, 135];
  List<String> boardState = ["", "", "", "", "", "", "", "", ""];
  late bool gameEnded;
  bool draw = false;
  @override
  void initState() {
    super.initState();
    gameEnded = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _headerText(),
            _board(),
            _resetbutton(),
          ],
        ),
      ),
    );
  }

  Widget _headerText() {
    if (!gameEnded) {
      return Text('Player ${player == PlayerState.playerX ? "X" : "O"} Turn');
    } else if (!draw) {
      return Text('Player ${player == PlayerState.playerX ? "X" : "O"} Won !');
    } else {
      return const Text("Draw !!");
    }
  }

  Widget _board() {
    return Stack(children: [
      Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: GridView.builder(
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              return _box(index);
            },
          ),
        ),
      ),
      Positioned(
          right: winCrossPosX,
          bottom: winCrossPosY,
          child: Transform.rotate(
            angle: math.pi / winCrossRot,
            child: Container(
              decoration: BoxDecoration(
                color: winCrossColor[gameEnded && !draw ? 1 : 0],
                borderRadius: const BorderRadius.all(Radius.circular(35)),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(
                          winCrossAlpha[gameEnded && !draw ? 1 : 0], 0, 0, 0),
                      offset: const Offset(5, 5))
                ],
              ),
              height: MediaQuery.of(context).size.height / 2.1,
              width: 15,
              margin: const EdgeInsets.only(top: 10),
            ),
          ))
    ]);
  }

  Widget _box(int index) {
    double sizeBottomLeft = 0,
        sizeBottomRight = 0,
        sizeTopLeft = 0,
        sizeTopRight = 0;
    switch (index) {
      case 0:
        sizeTopLeft = 30;
        break;
      case 2:
        sizeTopRight = 30;
        break;
      case 6:
        sizeBottomLeft = 30;
        break;
      case 8:
        sizeBottomRight = 30;
        break;
      default:
        sizeBottomLeft = 0;
        sizeBottomRight = 0;
        sizeTopLeft = 0;
        sizeTopRight = 0;
    }
    return InkWell(
      onTap: () {
        setState(() {
          if (boardState[index] == "" && !gameEnded) {
            boardState[index] = player == PlayerState.playerX ? "X" : "O";
            hasWon();
            if (!gameEnded) {
              player = player == PlayerState.playerX
                  ? PlayerState.playerY
                  : PlayerState.playerX;
            }
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(sizeBottomLeft),
            bottomRight: Radius.circular(sizeBottomRight),
            topLeft: Radius.circular(sizeTopLeft),
            topRight: Radius.circular(sizeTopRight),
          ),
          color: const Color.fromARGB(255, 244, 40, 84),
        ),
        child: Center(
          child: Text(
            boardState[index],
            style: const TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontFamily: 'Purple Smile',
                shadows: [
                  Shadow(
                    color: Colors.black,
                    offset: Offset(5, 5),
                  )
                ]),
          ),
        ),
      ),
    );
  }

  Widget _resetbutton() {
    return Container(
      height: 44.0,
      width: 150,
      margin: const EdgeInsets.only(top: 35),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 249, 209, 83),
            Color.fromARGB(255, 246, 171, 32)
          ])),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            boardState = ["", "", "", "", "", "", "", "", ""];
            gameEnded = false;
            draw = false;
            player = PlayerState.playerX;
          });
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        child: const Text(
          "Reset",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  void changePosition(int index1, int index2, int index3) {
    winCrossPosX = winCrossPositionsX[index1];
    winCrossPosY = winCrossPositionsY[index2];
    winCrossRot = winCrossRotations[index3];
  }

  void hasWon() {
    bool test = boardState.every((e) => e != "");
    if (test) {
      gameEnded = true;
      draw = true;
    }

    List<List<int>> winningPos = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];
    for (var element in winningPos) {
      String pos1 = boardState[element[0]];
      String pos2 = boardState[element[1]];
      String pos3 = boardState[element[2]];
      if (pos1 != "" && pos2 != "" && pos3 != "") {
        if (pos1 == pos2 && pos2 == pos3) {
          gameEnded = true;
          draw = false;
          switch (winningPos.indexOf(element)) {
            case 0:
              changePosition(1, 0, 3);
              break;
            case 1:
              changePosition(1, 1, 3);
              break;
            case 2:
              changePosition(1, 2, 3);
              break;
            case 3:
              changePosition(0, 1, 0);
              break;
            case 4:
              changePosition(1, 1, 0);
              break;
            case 5:
              changePosition(2, 1, 0);
              break;
            case 6:
              changePosition(1, 1, 2);
              break;
            case 7:
              changePosition(1, 1, 1);
              break;
          }
        }
      }
    }
  }
}
