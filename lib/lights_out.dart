import 'package:flutter/material.dart';
import 'package:tic_tac_toe/home.dart';
import 'package:tic_tac_toe/main.dart';
import 'globals.dart' as global;

class LightsOutPage extends StatelessWidget {
  const LightsOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: global.defaultAppBar("Lights Out !", context, () {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AppFirstPage(),
            ));
      }, true),
    );
  }
}
