import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pomodoro/src/utils/constants/constants.dart';

class RequestPermission {
  final VoidCallback? action;
  bool? granted;
  RequestPermission({this.action, this.granted});

  Future<void> requestPermissions() async {
    try {
      if (Platform.isIOS || Platform.isMacOS) {
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            );
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                MacOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            );
      } else if (Platform.isAndroid) {
        final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
            flutterLocalNotificationsPlugin
                .resolvePlatformSpecificImplementation<
                    AndroidFlutterLocalNotificationsPlugin>();

        granted = await androidImplementation?.requestPermission();
        // setState(() {
        //   _notificationsEnabled = granted ?? false;
        // });
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
