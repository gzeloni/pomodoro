// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pomodoro/main.dart';
import 'package:pomodoro/src/models/buttons.dart';
import 'package:pomodoro/src/models/menu_button.dart';
// import 'package:pomodoro/src/models/settings_buttons.dart';
import 'package:pomodoro/src/models/switch_colors.dart';

class Pomodoro extends StatefulWidget {
  const Pomodoro({super.key});

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> with WidgetsBindingObserver {
  // ignore: unused_field
  bool _notificationsEnabled = false;
  bool isStarted = false;
  Timer? countdownTimer;
  Duration myDuration = const Duration(minutes: 25);
  List<String> modes = ['Foco', 'Pausa curta', 'Pausa Longa'];
  int indexOf = 0;
  int cycle = 0;
  IconData modeIcon = Icons.spa_outlined;
  String minutes = '';
  String seconds = '';

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _isAndroidPermissionGranted();
    _requestPermissions();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
    super.initState();
  }

  Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;

      setState(() {
        _notificationsEnabled = granted;
      });
    }
  }

  Future<void> _requestPermissions() async {
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
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? granted = await androidImplementation?.requestPermission();
      setState(() {
        _notificationsEnabled = granted ?? false;
      });
    }
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationStream.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title!)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body!)
              : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    });
  }

  void _configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String? payload) async {});
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 22),
              child: Center(
                child: Container(
                  width: modes[indexOf].length == 4 ? 90 : 140,
                  height: 34,
                  decoration: BoxDecoration(
                    color: colorData200(indexOf),
                    border: Border.all(
                      color: colorData800(indexOf),
                      width: 1,
                    ),
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
                          color: colorData900(indexOf),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          modes[indexOf],
                          style: TextStyle(
                            color: colorData900(indexOf),
                          ),
                        )
                      ]),
                ),
              ),
            ),
            Center(
              child: Text(
                '$minutes\n$seconds',
                style: const TextStyle(
                  fontSize: 200,
                  fontWeight: FontWeight.bold,
                  height: 0.8,
                ),
              ),
            ),
            CustomButtons(
              firstButtonPressed: () {
                _showDialog();
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
              color900: colorData900(indexOf),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog() {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "Sair",
        style: TextStyle(color: colorData900(indexOf)),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: colorData50(indexOf),
      title: Text(
        "Menu",
        textAlign: TextAlign.center,
        style: TextStyle(color: colorData900(indexOf)),
      ),
      content: SizedBox(
        height: 150,
        width: 150,
        child: Column(children: [
          CustomIconButton(
            icon: Icons.leaderboard_outlined,
            indexOf: indexOf,
            onPressed: () {
              _analytics();
            },
            text: 'Estatísticas',
          ),
          CustomIconButton(
            icon: Icons.settings_outlined,
            indexOf: indexOf,
            onPressed: () {
              _settings();
            },
            text: 'Configurações',
          ),
        ]),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _settings() {
    Widget cancelButton = TextButton(
      child: Text(
        "Cancelar",
        style: TextStyle(color: colorData900(indexOf)),
      ),
      onPressed: () {
        for (int i = 0; i < 2; i++) {
          Navigator.of(context).pop();
        }
      },
    );
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "Confirmar",
        style: TextStyle(color: colorData900(indexOf)),
      ),
      onPressed: () {
        for (int i = 0; i < 2; i++) {
          Navigator.of(context).pop();
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: colorData50(indexOf),
      title: Text(
        "Configurações",
        textAlign: TextAlign.center,
        style: TextStyle(color: colorData900(indexOf)),
      ),
      content: SizedBox(
        height: 150,
        width: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Aguarde a próxima atualização.',
              textAlign: TextAlign.center,
              style: TextStyle(color: colorData900(indexOf)),
            ),
          ],
        ),
      ),
      actions: [cancelButton, okButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _analytics() {
    Widget cancelButton = TextButton(
      child: Text(
        "Cancelar",
        style: TextStyle(color: colorData900(indexOf)),
      ),
      onPressed: () {
        for (int i = 0; i < 2; i++) {
          Navigator.of(context).pop();
        }
      },
    );
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "Confirmar",
        style: TextStyle(color: colorData900(indexOf)),
      ),
      onPressed: () {
        for (int i = 0; i < 2; i++) {
          Navigator.of(context).pop();
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: colorData50(indexOf),
      title: Text(
        "Estatísticas",
        textAlign: TextAlign.center,
        style: TextStyle(color: colorData900(indexOf)),
      ),
      content: SizedBox(
        height: 150,
        width: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Aguarde a próxima atualização.',
              textAlign: TextAlign.center,
              style: TextStyle(color: colorData900(indexOf)),
            ),
          ],
        ),
      ),
      actions: [cancelButton, okButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive && isStarted == true) {
      _showProgressNotification();
    } else if (state == AppLifecycleState.detached) {
      if (isStarted == true) {
        resetTimer();
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
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
    } else if (cycle == 1 || cycle == 3 || cycle == 5 || cycle == 7) {
      setState(() {
        indexOf = 1;
        switchTimer();
        if (isStarted == false) {
          isStarted = !isStarted;
          startTimer();
          _showProgressNotification();
        }
      });
    } else if (cycle == 2 || cycle == 4 || cycle == 6) {
      setState(() {
        indexOf = 0;
        switchTimer();
        if (isStarted == false) {
          isStarted = !isStarted;
          startTimer();
          _showProgressNotification();
        }
      });
    } else if (cycle == 8) {
      setState(() {
        indexOf = 2;
        switchTimer();
        if (isStarted == false) {
          isStarted = !isStarted;
          startTimer();
          _showProgressNotification();
        }
      });
    } else if (cycle == 9) {
      setState(() {
        indexOf = 0;
        isStarted = false;
        switchTimer();
        resetTimer();
        _showNotification();
        _stopForegroundService();
      });
    }
  }

  Future<void> _stopForegroundService() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.stopForegroundService();
  }

  Future<void> _showProgressNotification() async {
    id++;
    final int progressId = id;
    int maxProgress = myDuration.inSeconds.toInt();
    if (modes[indexOf] == modes[0]) {}
    for (int i = 0; i <= maxProgress; i++) {
      await Future<void>.delayed(const Duration(seconds: 1), () async {
        final AndroidNotificationDetails androidNotificationDetails =
            AndroidNotificationDetails('Pomodoro', 'pomodoro app',
                channelDescription: 'timer',
                channelShowBadge: false,
                importance: Importance.max,
                priority: Priority.high,
                onlyAlertOnce: true,
                showProgress: false,
                indeterminate: true,
                maxProgress: maxProgress,
                progress: i);
        final NotificationDetails notificationDetails =
            NotificationDetails(android: androidNotificationDetails);
        await flutterLocalNotificationsPlugin.show(
            progressId,
            modes[indexOf] == modes[0]
                ? 'Você está no ciclo de foco.'
                : modes[indexOf] == modes[1]
                    ? 'Hora da pausa!'
                    : modes[indexOf] == modes[1]
                        ? 'Você ganhou 15 minutos de pausa!'
                        : '',
            '$minutes:$seconds',
            notificationDetails,
            payload: 'item x');
      });
    }
  }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        id++,
        'Pomodoro Finalizado!',
        'Você terminou todos os ciclos do Pomodoro. Parabéns! :)',
        notificationDetails,
        payload: 'item x');
  }
}

// 986 - 78 até 372 - 618
