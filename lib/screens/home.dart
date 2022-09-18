// ignore_for_file: prefer_const_constructors
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  late int _duracaoTimer = 1500;
  late int _voltas = 0;
  final CountDownController _controller = CountDownController();
  bool iniciaOuPara = true;
  IconData _botaoRelogio = Icons.play_arrow;
  Future<void> readData() async {
    final data = await SharedPreferences.getInstance();
    setState(() {
      _voltas = (data.getInt('counter') ?? 0);
      _duracaoTimer = (data.getInt('duracaoTimer') ?? 0); // ...
    });
  }

  @override
  void initState() {
    super.initState();
    readData();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  AppLifecycleState? _notificacao;

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

  Future<void> _voltasCount() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _voltas = (prefs.getInt('voltas') ?? 0) + 1;
      prefs.setInt('voltas', _voltas);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Pomodoro"),
        centerTitle: true,
        shadowColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Center(
            child: CircularCountDownTimer(
              duration: _duracaoTimer,
              initialDuration: 0,
              controller: _controller,
              width: MediaQuery.of(context).size.width / 1.6,
              height: MediaQuery.of(context).size.height / 2,
              ringColor: Colors.grey[300]!,
              ringGradient: null,
              fillColor: Color.fromARGB(255, 224, 9, 38),
              fillGradient: null,
              backgroundColor: Colors.white,
              backgroundGradient: null,
              strokeWidth: 22.5,
              strokeCap: StrokeCap.round,
              textStyle: const TextStyle(
                fontSize: 33.0,
                color: Color.fromARGB(255, 224, 9, 38),
                fontWeight: FontWeight.bold,
              ),
              textFormat: CountdownTextFormat.MM_SS,
              isReverse: true,
              isReverseAnimation: false,
              isTimerTextShown: true,
              autoStart: false,
              onComplete: () {
                _voltasCount();
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
                      color: Color.fromARGB(255, 224, 9, 38),
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )),
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
                      color: Color.fromARGB(255, 224, 9, 38),
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )),
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
