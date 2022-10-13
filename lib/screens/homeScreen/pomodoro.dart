import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class Pomodoro extends StatefulWidget {
  const Pomodoro({super.key});

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> with WidgetsBindingObserver {
  late int _duracaoTimer = 1500;
  late int _voltas = 0;
  final CountDownController _controller = CountDownController();
  bool iniciaOuPara = true;
  IconData _botaoRelogio = Icons.play_arrow;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  AppLifecycleState? _notificacao;

  void detectLifecycleState() {
    if (_notificacao == AppLifecycleState.detached) {
      _controller.pause();
      _controller.reset();
    }
  }

  startStop() {
    if (iniciaOuPara) {
      startCountDown();
    } else {
      stopCountDown();
    }
  }

  startCountDown() {
    setState(() {
      iniciaOuPara = false;
      _controller.start();
      _botaoRelogio = Icons.stop;
    });
  }

  stopCountDown() {
    setState(() {
      iniciaOuPara = true;
      _controller.pause();
      _botaoRelogio = Icons.play_arrow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Pomodoro",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 20, left: 10),
            child: Text(
              'Bem vindo, Gustavo',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Center(
            child: CircularCountDownTimer(
              duration: _duracaoTimer,
              initialDuration: 0,
              controller: _controller,
              width: MediaQuery.of(context).size.width / 1.6,
              height: MediaQuery.of(context).size.height / 2,
              ringColor: Colors.grey[300]!,
              ringGradient: null,
              fillColor: Color.fromARGB(255, 238, 4, 4),
              fillGradient: null,
              backgroundColor: Colors.white,
              strokeWidth: 22.5,
              strokeCap: StrokeCap.round,
              textStyle: const TextStyle(
                fontSize: 33.0,
                color: Color.fromARGB(255, 238, 4, 4),
                fontWeight: FontWeight.bold,
              ),
              textFormat: CountdownTextFormat.MM_SS,
              isReverse: true,
              isReverseAnimation: false,
              isTimerTextShown: true,
              autoStart: false,
              onComplete: () {
                iniciaOuPara = true;
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              "Você completou $_voltas voltas!",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(38),
                      color: Color.fromARGB(255, 238, 4, 4),
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      child: Icon(
                        _botaoRelogio,
                        color: Colors.white,
                        size: 50,
                      ),
                      onPressed: () {
                        startStop();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 120,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(38),
                      color: Color.fromARGB(255, 238, 4, 4),
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      child: Icon(
                        Icons.replay,
                        color: Colors.white,
                        size: 50,
                      ),
                      onPressed: () {
                        _controller.reset();
                        _controller.start();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 35,
          ),
        ],
      ),
    );
  }
}
