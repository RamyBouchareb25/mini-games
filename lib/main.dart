import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:tic_tac_toe/home.dart';
import 'globals.dart' as global;

enum PlayerState {
  playerX,
  playerY,
}

void main() {
  runApp(const AppFirstPage());
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
  final Color pinkColor = global.pink;
  final Color yellowColor = global.yellow;
  final String funnyFont = global.purpleSmileFont;
  final String mainFont = global.mainFont;
  static PlayerState player = PlayerState.playerX;
  List<String> boardState = ["", "", "", "", "", "", "", "", ""];
  List<int> winningCases = [20, 20, 20];
  late bool gameEnded;
  bool draw = false;
  @override
  void initState() {
    super.initState();
    gameEnded = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(255, 253, 218, 229),
        Color.fromARGB(255, 253, 239, 241)
      ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
      child: Scaffold(
        appBar: global.defaultAppBar("Tic Tac Toe", context, () {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AppFirstPage(),
              ));
        }, true),
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _headerText(),
              _board(),
              global.standardButton(resetFunction, "Reset"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerText() {
    TextStyle font = TextStyle(
        fontFamily: "Helvetica Rounded Bold", fontSize: 25, color: pinkColor);
    if (!gameEnded) {
      return Text(
        'Player ${player == PlayerState.playerX ? "X" : "O"} Turn',
        style: font,
      );
    } else if (!draw) {
      return Text(
        'Player ${player == PlayerState.playerX ? "X" : "O"} Won !',
        style: font,
      );
    } else {
      return Text(
        "Draw !!",
        style: font,
      );
    }
  }

  Widget _board() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: GridView.builder(
        itemCount: 9,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return _box(index);
        },
      ),
    );
  }

  Widget _box(int index) {
    double sizeBottomLeft = 0,
        sizeBottomRight = 0,
        sizeTopLeft = 0,
        sizeTopRight = 0;
    Color color = const Color.fromARGB(255, 244, 40, 84);
    winningCases.contains(index)
        ? color = const Color.fromARGB(255, 249, 212, 89)
        : const Color.fromARGB(255, 244, 40, 84);
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
    return DottedBorder(
      color: Colors.white,
      child: InkWell(
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
            color: color,
          ),
          child: Center(
            child: Text(
              boardState[index],
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontFamily: funnyFont,
                  shadows: const [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(5, 5),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  void resetFunction() {
    setState(() {
      boardState = ["", "", "", "", "", "", "", "", ""];
      gameEnded = false;
      draw = false;
      player = PlayerState.playerX;
      winningCases = [20, 20, 20];
    });
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
          winningCases[0] = element[0];
          winningCases[1] = element[1];
          winningCases[2] = element[2];
        }
      }
    }
  }
}
