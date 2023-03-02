library globals;

import 'package:flutter/material.dart';
import 'dart:ui';

const Color pink = Color.fromARGB(255, 242, 40, 83);
const Color yellow = Color.fromARGB(255, 249, 212, 89);
const String purpleSmileFont = "Purple Smile";
const String mainFont = "Helvetica Rounded Bold";

Widget standardButton(void Function() onTap, String text) {
  return Container(
    height: 44.0,
    width: 150,
    margin: const EdgeInsets.only(top: 35),
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 249, 209, 83),
          Color.fromARGB(255, 246, 171, 32)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
      child: Text(
        text,
        style: const TextStyle(color: Colors.black),
      ),
    ),
  );
}

AppBar defaultAppBar(String text, BuildContext context, void Function() onPress,
    bool displayReturnButton) {
  if (displayReturnButton) {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      title: Text(
        text,
        style: const TextStyle(color: pink, fontFamily: mainFont, fontSize: 35),
      ),
      centerTitle: true,
      leading: InkWell(
        onTap: onPress,
        child: const Icon(Icons.arrow_back),
      ),
      iconTheme: const IconThemeData(color: pink, size: 35),
    );
  } else {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      title: Text(
        text,
        style: const TextStyle(color: pink, fontFamily: mainFont, fontSize: 35),
      ),
      centerTitle: true,
      iconTheme: const IconThemeData(color: pink, size: 35),
    );
  }
}
