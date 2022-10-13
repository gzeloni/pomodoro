import "package:flutter/material.dart";
import 'package:pomodoro_app/screens/loginScreens/loginPage.dart';
import 'package:pomodoro_app/screens/homeScreen/pomodoro.dart';
import 'package:pomodoro_app/screens/settings/settings.dart';
import 'package:pomodoro_app/screens/todos/todos.dart';

class Screens extends StatefulWidget {
  const Screens({super.key});

  @override
  State<Screens> createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  // declaração de variáveis
  int indexOf = 0; // posíção dos ítens na barra de navegação.

  final telas = const [
    Pomodoro(),
    Todos(),
    Pomodoro(),
    LoginScreen(),
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
        iconSize: 32,
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
            icon: Icon(Icons.home),
            label: 'Tarefas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Iniciar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stairs),
            label: 'Estatísticas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
