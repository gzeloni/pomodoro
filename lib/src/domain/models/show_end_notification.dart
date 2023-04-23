import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro/src/utils/constants/constants.dart';

Future<void> showEndNotification(Duration duration) async {
  final date = DateTime.now().add(duration);
  final formatDate = DateFormat('hh:mm');
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('your channel id', 'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');
  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.show(
      id++,
      'Pomodoro Finalizado!',
      'Parabéns! Que tal mais uma rodada? :)',
      // 'Você terminou todos os ciclos do Pomodoro. Parabéns! :)',
      notificationDetails,
      payload: 'item x');
}
