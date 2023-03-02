import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/lights_out.dart';
import 'package:tic_tac_toe/main.dart';
import 'globals.dart' as global;

class AppFirstPage extends StatelessWidget {
  const AppFirstPage({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});
  static Color pink = global.pink;
  static Color yellow = global.yellow;
  static String funnyFont = global.purpleSmileFont;
  static String mainFont = global.mainFont;
  static TextStyle mainStyle = TextStyle(
    color: pink,
    fontFamily: mainFont,
    fontSize: 40,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(255, 253, 218, 229),
        Color.fromARGB(255, 253, 239, 241)
      ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: global.defaultAppBar("Home", context, () {}, false),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ticTacToeButton(context),
              lightsOutButton(context),
              quitButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget ticTacToeButton(BuildContext context) {
    return global.standardButton(() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyApp(),
          ));
    }, "Tic Tac Toe");
  }

  Widget lightsOutButton(BuildContext context) {
    return global.standardButton(() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LightsOutPage(),
          ));
    }, "Lights Out");
  }

  Widget quitButton() {
    return global.standardButton(() {
      exit(0);
    }, "Quit");
  }
}
