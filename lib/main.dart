import 'package:flutter/material.dart';
import 'package:pomodoro_app/screens/functions/navbar.dart';

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
      home: Screens(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color.fromARGB(255, 238, 4, 4),
          secondary: Color.fromARGB(255, 238, 4, 4),
        ),
      ),
    );
  }
}
