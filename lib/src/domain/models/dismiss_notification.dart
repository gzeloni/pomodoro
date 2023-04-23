import 'package:pomodoro/src/utils/constants/constants.dart';

Future<void> dismissNotification() async {
  await flutterLocalNotificationsPlugin.cancelAll();
}
