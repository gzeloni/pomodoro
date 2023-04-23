import 'dart:io';

import 'package:android_power_manager/android_power_manager.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

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
    debugPrint(e.toString());
  }
}
