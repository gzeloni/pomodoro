// ignore_for_file: prefer_const_constructors
import 'package:pomodoro_app/screens/homeScreen/home.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(Pomodoro());
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
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color.fromARGB(255, 4, 211, 238),
          secondary: Color.fromARGB(255, 4, 211, 238),
        ),
      ),
    );
  }
}
