import 'package:flutter/material.dart';
import 'package:pomodoro/src/utils/constants/constants.dart';

Future<void> dismissNotification() async {
  try {
    await flutterLocalNotificationsPlugin.cancelAll();
  } on Exception catch (e) {
    debugPrint(e.toString());
  }
}
