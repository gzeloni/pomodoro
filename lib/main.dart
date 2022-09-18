// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:pomodoro_app/screens/home.dart';
import 'package:pomodoro_app/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_app/screens/navbar.dart';

void main() async {
  runApp(SplashScreen());
  Timer(Duration(seconds: 4), () => runApp(Pomodoro()));
}

class Pomodoro extends StatefulWidget {
  const Pomodoro({super.key});

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /* Tela de animação antes do app abrir na tela inicial */
      home: Screens(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color.fromARGB(255, 224, 9, 38),
          secondary: Color.fromARGB(255, 224, 9, 38),
        ),
      ),
    );
  }
}
