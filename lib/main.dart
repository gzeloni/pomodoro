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

void init(BuildContext context) async {
  try {
    var status = await Permission.ignoreBatteryOptimizations.status;
    if (status.isGranted) {
      if (await AndroidPowerManager.isIgnoringBatteryOptimizations == false) {
        AndroidPowerManager.requestIgnoreBatteryOptimizations();
      }
    } else {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.ignoreBatteryOptimizations,
      ].request();
      if (statuses[Permission.ignoreBatteryOptimizations]!.isGranted) {
        AndroidPowerManager.requestIgnoreBatteryOptimizations();
      } else {
        exit(0);
      }
    }
  } catch (e) {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(255, 126, 72, 181),
        duration: const Duration(seconds: 5),
        content: Text(
          e.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    init(context);
    return MaterialApp(
      home: const Pomodoro(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
    );
  }
}
