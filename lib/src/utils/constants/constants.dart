import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

int id = 0;
String? selectedNotificationPayload;
const String urlLaunchActionId = 'id_1';
const String navigationActionId = 'id_3';
const String darwinNotificationCategoryText = 'textCategory';
const String darwinNotificationCategoryPlain = 'plainCategory';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
    StreamController<ReceivedNotification>.broadcast();

final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

const MethodChannel platform =
    MethodChannel('dexterx.dev/flutter_local_notifications_example');

const String portName = 'notification_send_port';

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}
