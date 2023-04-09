import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pomodoro/src/models/buttons.dart';
import 'package:pomodoro/src/models/menu_button.dart';
import 'package:pomodoro/src/models/switch_colors.dart';

class Pomodoro extends StatefulWidget {
  const Pomodoro({super.key});

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> with WidgetsBindingObserver {
  bool isStarted = false;
  Timer? countdownTimer;
  Duration myDuration = const Duration(minutes: 25);
  String mensagem = 'Bem-vinda de volta gatinha :)';
  List<String> modes = ['Foco', 'Pausa curta', 'Pausa Longa'];
  int indexOf = 1;
  IconData modeIcon = Icons.spa_outlined;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);
  //   switch (state) {
  //     case AppLifecycleState.inactive:
  //       break;
  //     case AppLifecycleState.paused:
  //       break;
  //     case AppLifecycleState.resumed:
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           backgroundColor: const Color.fromARGB(255, 126, 72, 181),
  //           duration: const Duration(seconds: 5),
  //           content: Text(
  //             mensagem,
  //             textAlign: TextAlign.center,
  //             style: const TextStyle(color: Colors.white, fontSize: 18),
  //           ),
  //         ),
  //       );
  //       break;
  //     case AppLifecycleState.detached:
  //       if (isStarted == true) {
  //         resetTimer();
  //       }
  //       break;
  //   }
  // }

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
              ? myDuration = const Duration(minutes: 15)
              : indexOf == 2
                  ? myDuration = const Duration(minutes: 50)
                  : myDuration = const Duration(minutes: 25);
    });
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
        stopTimer();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
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
                _exibirDialogo();
              },
              secondButtonPressed: () {
                setState(() {
                  if (isStarted == false) {
                    isStarted = !isStarted;
                    startTimer();
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

  void _exibirDialogo() {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "OK",
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
              onPressed: () {},
              text: 'Estatísticas'),
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
}

// 986 - 78 até 372 - 618