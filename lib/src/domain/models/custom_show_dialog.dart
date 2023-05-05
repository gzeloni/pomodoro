import 'package:flutter/material.dart';
import 'package:pomodoro/src/domain/models/settings_dialog.dart';
import 'package:pomodoro/src/domain/models/switch_colors.dart';
import 'package:pomodoro/src/presentation/widgets/menu_button.dart';

void customShowDialog(BuildContext context, int indexOf) {
  // set up the button
  Widget okButton = TextButton(
    child: Text(
      "Sair",
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
      "Menu",
      textAlign: TextAlign.center,
      style: TextStyle(color: colorData900(indexOf)),
    ),
    content: SizedBox(
      height: 150,
      width: 150,
      child: Column(children: [
        CustomIconButton(
          icon: Icons.settings_outlined,
          indexOf: indexOf,
          onPressed: () {
            settings(context, indexOf);
          },
          text: 'Configurações',
        ),
      ]),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
