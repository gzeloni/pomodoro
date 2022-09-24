import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _PopUpState();
}

class _PopUpState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 235, 235),
    );
  }
}

/* 
1- Menu seletor de temas
2- Botão de limpar os dados de uso
3- Me dê ideias :) */