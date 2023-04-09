// import 'dart:io';

import 'dart:io';

import 'package:android_power_manager/android_power_manager.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pomodoro/src/screens/pomodoro.dart';

void main() async {
  runApp(const AppWidget());
}

// void init() async {
//   var status = await Permission.ignoreBatteryOptimizations.status;
//   if (status.isGranted) {
//     if (await AndroidPowerManager.isIgnoringBatteryOptimizations == false) {
//       AndroidPowerManager.requestIgnoreBatteryOptimizations();
//     }
//   } else {
//     Map<Permission, PermissionStatus> statuses = await [
//       Permission.ignoreBatteryOptimizations,
//     ].request();
//     if (statuses[Permission.ignoreBatteryOptimizations]!.isGranted) {
//       AndroidPowerManager.requestIgnoreBatteryOptimizations();
//     } else {
//       exit(0);
//     }
//   }
// }

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    //init();
    return MaterialApp(
      home: const Pomodoro(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
    );
  }
}
