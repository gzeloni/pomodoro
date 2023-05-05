// ignore_for_file: unused_field

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pomodoro/src/domain/models/configure_did_receive_local_notifications_subject.dart';
import 'package:pomodoro/src/domain/models/configure_select_notification_subject.dart';
import 'package:pomodoro/src/domain/models/custom_show_dialog.dart';
import 'package:pomodoro/src/domain/models/dismiss_notification.dart';
import 'package:pomodoro/src/domain/models/is_android_permission_granted.dart';
import 'package:pomodoro/src/domain/models/request_permission.dart';
import 'package:pomodoro/src/domain/models/show_end_notification.dart';
import 'package:pomodoro/src/domain/models/show_notification.dart';
import 'package:pomodoro/src/domain/models/switch_colors.dart';
import 'package:pomodoro/src/presentation/widgets/buttons.dart';
import 'package:pomodoro/src/utils/constants/constants.dart';

class Pomodoro extends StatefulWidget {
  const Pomodoro({super.key});

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> with WidgetsBindingObserver {
  bool _notificationsEnabled = false;
  bool isStarted = false;
  bool? granted;
  int cycle = 0;
  int indexOf = 0;
  String minutes = '';
  String seconds = '';
  List<String> modes = ['Foco', 'Pausa curta', 'Pausa Longa'];
  Duration myDuration = const Duration(minutes: 25);
  IconData modeIcon = Icons.spa_outlined;
  Timer? countdownTimer;
  IsAndroidPermissionGranted checkAndroidPermission =
      IsAndroidPermissionGranted();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    checkAndroidPermission.isAndroidPermissionGranted(() => setState(() {
          _notificationsEnabled = checkAndroidPermission.granted;
        }));
    RequestPermission(
      action: () async {
        setState(() {
          _notificationsEnabled = granted ?? false;
        });
      },
    ).requestPermissions();
    configureDidReceiveLocalNotificationSubject(context);
    configureSelectNotificationSubject();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    didReceiveLocalNotificationStream.close();
    selectNotificationStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    minutes = strDigits(myDuration.inMinutes.remainder(60));
    seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Scaffold(
        backgroundColor: colorData50(indexOf),
        body: SafeArea(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 22),
              child: Center(
                  child: Container(
                      width: modes[indexOf].length == 4 ? 90 : 140,
                      height: 34,
                      decoration: BoxDecoration(
                        color: colorData200(indexOf),
                        border:
                            Border.all(color: colorData800(indexOf), width: 1),
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                                indexOf == 0
                                    ? Icons.spa_outlined
                                    : indexOf == 1
                                        ? Icons.coffee
                                        : indexOf == 2
                                            ? Icons.eco_outlined
                                            : Icons.error,
                                color: colorData900(indexOf)),
                            const SizedBox(width: 8),
                            Text(modes[indexOf],
                                style: TextStyle(color: colorData900(indexOf)))
                          ])))),
          Center(
              child: Text('$minutes\n$seconds',
                  style: const TextStyle(
                      fontSize: 200,
                      fontWeight: FontWeight.bold,
                      height: 0.8))),
          CustomButtons(
              firstButtonPressed: () {
                customShowDialog(context, indexOf);
              },
              secondButtonPressed: () {
                setState(() {
                  if (isStarted == false) {
                    isStarted = !isStarted;
                    pomodoroCycle();
                  } else {
                    isStarted = !isStarted;
                    resetTimer();
                  }
                });
              },
              thirdButtonPressed: () {
                setState(() {
                  if (indexOf >= 2) {
                    indexOf = 0;
                    switchTimer();
                  } else {
                    indexOf++;
                    switchTimer();
                  }
                });
              },
              firstButtonIcon: Icons.more_horiz,
              centerButtonIcon: isStarted ? Icons.pause : Icons.play_arrow,
              endButtonIcon: Icons.double_arrow,
              color200: colorData200(indexOf),
              color400: colorData400(indexOf),
              color900: colorData900(indexOf))
        ])));
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void resetTimer() {
    stopTimer();
    setState(() => myDuration = const Duration(minutes: 25));
  }

  void switchTimer() {
    if (isStarted == true) {
      stopTimer();
      isStarted = !isStarted;
    }
    setState(() {
      indexOf == 0
          ? myDuration = const Duration(minutes: 25)
          : indexOf == 1
              ? myDuration = const Duration(minutes: 5)
              : indexOf == 2
                  ? myDuration = const Duration(minutes: 15)
                  : myDuration = const Duration(minutes: 25);
    });
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds <= 0) {
        countdownTimer!.cancel();
        stopTimer();
        cycle++;
        pomodoroCycle();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  void pomodoroCycle() {
    if (cycle == 0) {
      startTimer();
      showNotification(myDuration, modes, indexOf);
    } else if (cycle == 1 || cycle == 3 || cycle == 5 || cycle == 7) {
      setState(() {
        indexOf = 1;
        switchTimer();
        if (isStarted == false) {
          isStarted = !isStarted;
          startTimer();
          dismissNotification();
          showNotification(myDuration, modes, indexOf);
        }
      });
    } else if (cycle == 2 || cycle == 4 || cycle == 6) {
      setState(() {
        indexOf = 0;
        switchTimer();
        if (isStarted == false) {
          isStarted = !isStarted;
          startTimer();
          dismissNotification();
          showNotification(myDuration, modes, indexOf);
        }
      });
    } else if (cycle == 8) {
      setState(() {
        indexOf = 2;
        switchTimer();
        if (isStarted == false) {
          isStarted = !isStarted;
          startTimer();
          dismissNotification();
          showNotification(myDuration, modes, indexOf);
        }
      });
    } else if (cycle == 9) {
      setState(() {
        indexOf = 0;
        cycle = 9;
        isStarted = false;
        switchTimer();
        resetTimer();
        dismissNotification();
        showEndNotification(myDuration);
      });
    }
  }
}
