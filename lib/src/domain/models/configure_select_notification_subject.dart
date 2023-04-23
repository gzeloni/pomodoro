import 'package:flutter/material.dart';
import 'package:pomodoro/src/utils/constants/constants.dart';

void configureSelectNotificationSubject() {
  try {
    selectNotificationStream.stream.listen((String? payload) async {});
  } on Exception catch (e) {
    debugPrint(e.toString());
  }
}
