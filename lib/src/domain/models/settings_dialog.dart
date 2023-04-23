import 'package:flutter/material.dart';
import 'package:pomodoro/src/domain/models/switch_colors.dart';

void settings(BuildContext context, int indexOf) {
  Widget cancelButton = TextButton(
    child: Text(
      "Cancelar",
      style: TextStyle(color: colorData900(indexOf)),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  // set up the button
  Widget okButton = TextButton(
    child: Text(
      "Confirmar",
      style: TextStyle(color: colorData900(indexOf)),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: colorData50(indexOf),
    title: Text(
      "Configurações",
      textAlign: TextAlign.center,
      style: TextStyle(color: colorData900(indexOf)),
    ),
    content: SizedBox(
      height: 150,
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Aguarde a próxima atualização.',
            textAlign: TextAlign.center,
            style: TextStyle(color: colorData900(indexOf)),
          ),
        ],
      ),
    ),
    actions: [cancelButton, okButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
