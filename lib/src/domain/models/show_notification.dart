import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro/src/utils/constants/constants.dart';

Future<void> showNotification(
    Duration duration, List<String> modes, int indexOf) async {
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
      modes[indexOf] == modes[0]
          ? 'Você está no ciclo de foco.'
          : modes[indexOf] == modes[1]
              ? 'Hora da pausa!'
              : modes[indexOf] == modes[1]
                  ? 'Você ganhou 15 minutos de pausa!'
                  : '',
      'Próximo ciclo: ${formatDate.format(date)}',
      // 'Você terminou todos os ciclos do Pomodoro. Parabéns! :)',
      notificationDetails,
      payload: 'item x');
}
