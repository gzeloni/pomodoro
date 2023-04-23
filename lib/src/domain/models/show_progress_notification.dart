// Future<void> _showProgressNotification() async {
//     id++;
//     final int progressId = id;
//     int maxProgress = myDuration.inSeconds.toInt();
//     if (modes[indexOf] == modes[0]) {}
//     for (int i = 0; i <= maxProgress; i++) {
//       await Future<void>.delayed(const Duration(seconds: 1), () async {
//         final AndroidNotificationDetails androidNotificationDetails =
//             AndroidNotificationDetails('Pomodoro', 'pomodoro app',
//                 channelDescription: 'timer',
//                 channelShowBadge: false,
//                 importance: Importance.max,
//                 priority: Priority.high,
//                 onlyAlertOnce: true,
//                 showProgress: false,
//                 indeterminate: true,
//                 maxProgress: maxProgress,
//                 progress: i);
//         final NotificationDetails notificationDetails =
//             NotificationDetails(android: androidNotificationDetails);
//         await flutterLocalNotificationsPlugin.show(
//             progressId,
//             modes[indexOf] == modes[0]
//                 ? 'Você está no ciclo de foco.'
//                 : modes[indexOf] == modes[1]
//                     ? 'Hora da pausa!'
//                     : modes[indexOf] == modes[1]
//                         ? 'Você ganhou 15 minutos de pausa!'
//                         : '',
//             '$minutes:$seconds',
//             notificationDetails,
//             payload: 'item x');
//       });
//     }
//   }