// ignore_for_file: unused_local_variable
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pomodoro/src/utils/constants/constants.dart';

Future<void> isAndroidPermissionGranted(VoidCallback? action) async {
  try {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;
    }
  } on Exception catch (e) {
    debugPrint(e.toString());
  }
}

class IsAndroidPermissionGranted {
  bool granted = false;
  Future<void> isAndroidPermissionGranted(VoidCallback? action) async {
    try {
      if (Platform.isAndroid) {
        granted = await flutterLocalNotificationsPlugin
                .resolvePlatformSpecificImplementation<
                    AndroidFlutterLocalNotificationsPlugin>()
                ?.areNotificationsEnabled() ??
            false;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
