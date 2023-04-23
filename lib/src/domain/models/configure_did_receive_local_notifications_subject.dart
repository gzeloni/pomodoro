import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro/src/utils/constants/constants.dart';

void configureDidReceiveLocalNotificationSubject(BuildContext context) {
  didReceiveLocalNotificationStream.stream.listen(
    (ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title!)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body!)
              : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    },
  );
}
