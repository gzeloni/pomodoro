import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pomodoro/src/utils/constants/constants.dart';

Future<void> showEndNotification(Duration duration) async {
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('id_1', 'com.pomodoro.notification_channel',
          channelDescription: 'com.pomodoro.end_cycle',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');
  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);
  try {
    await flutterLocalNotificationsPlugin.show(
        id++,
        'Pomodoro Finalizado!',
        'Parabéns! Que tal mais uma rodada? :)',
        // 'Você terminou todos os ciclos do Pomodoro. Parabéns! :)',
        notificationDetails,
        payload: 'item x');
  } on Exception catch (e) {
    debugPrint(e.toString());
  }
}
