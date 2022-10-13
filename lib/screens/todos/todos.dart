import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Todos extends StatefulWidget {
  const Todos({super.key});

  @override
  State<Todos> createState() => _TodosState();
}

class _TodosState extends State<Todos> {
  final TextEditingController todoController = TextEditingController();

  // -----------------
  List<String> todos = [];
  Map<List, String> teste = {};
  DateTime teste2 = DateTime.now();
  // -----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Tarefas",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: todoController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Adicione uma tarefa",
                      hintText: "Ex: Estudar Flutter",
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(17),
                  ),
                  onPressed: () {
                    String text = todoController.text;
                    setState(() {
                      todos.add(text);
                    });
                  },
                  child: Icon(
                    Icons.add,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListView(
                shrinkWrap: true,
                children: [
                  for (String todo in todos)
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        tileColor: Color.fromARGB(230, 224, 224, 224),
                        title: Text(
                          todo,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        subtitle: Text(
                          DateFormat('HH:mm:ss').format(teste2),
                          style: TextStyle(
                            color: Color.fromARGB(255, 80, 80, 80),
                            fontSize: 14,
                          ),
                        ),
                        leading: Icon(
                          Icons.android,
                          size: 30,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

// CARALHO BAGULHO BUGADO VAI SE FODER MEU PARCEIRO