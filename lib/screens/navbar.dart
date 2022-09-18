import "package:flutter/material.dart";
import 'package:pomodoro_app/screens/home.dart';
import 'package:pomodoro_app/screens/challenge.dart';
import 'package:pomodoro_app/screens/settings.dart';

class Screens extends StatefulWidget {
  const Screens({super.key});

  @override
  State<Screens> createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  // declaração de variáveis
  int indexOf = 0; // posíção dos ítens na barra de navegação.

  final telas = const [
    Home(),
    Challenge(),
    Settings(),
  ]; /* Botões da barra de navegação.
  Alterar essa ordem altera a posíção dos itens na barra, é um valor indexado.*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: indexOf,
        children: telas,
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 35,
        selectedFontSize: 15,
        unselectedFontSize: 14,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(255, 31, 31, 31),
        currentIndex: indexOf,
        onTap: (index) => setState(() => indexOf = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dangerous),
            label: 'Desafio Diário',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_suggest),
            label: 'Configurações',
          ),
        ],
      ),
    );
  }
}
