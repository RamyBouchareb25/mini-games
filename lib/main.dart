import 'package:flutter/material.dart';

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
      return Text('Player ${player == PlayerState.playerX ? "X" : "Y"} Turn');
    } else if (!draw) {
      return Text('Player ${player == PlayerState.playerX ? "X" : "Y"} Won !');
    } else {
      return const Text("Draw !!");
    }
  }

  Widget _board() {
    return Align(
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
    );
  }

  Widget _box(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          if (boardState[index] == "" && !gameEnded) {
            boardState[index] = player == PlayerState.playerX ? "X" : "Y";
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
        color: const Color.fromARGB(255, 84, 84, 84),
        margin: const EdgeInsets.all(5),
        child: Center(
          child: Text(
            boardState[index],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 50,
            ),
          ),
        ),
      ),
    );
  }

  Widget _resetbutton() {
    return ElevatedButton(
      child: const Text("Reset"),
      onPressed: () {
        setState(() {
          boardState = ["", "", "", "", "", "", "", "", "", ""];
          gameEnded = false;
          draw = false;
          player = PlayerState.playerX;
        });
      },
    );
  }

  void hasWon() {
    bool test = boardState.every((e) => e != "");
    print('test = $test');
    print(boardState);
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
        }
      }
    }
  }
}
