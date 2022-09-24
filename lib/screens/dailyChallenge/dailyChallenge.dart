// ignore_for_file: prefer_const_constructors
// dependências usadas no programa.
import 'dart:async';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Challenge extends StatefulWidget {
  const Challenge({super.key});

  @override
  State<Challenge> createState() => _ChallengeState();
}

class _ChallengeState extends State<Challenge> with WidgetsBindingObserver {
  // declaração de variáveis
  late String _desafio = "Você ainda não completou o desafio diário";

  late bool _desafioCompletado =
      false; // booleano para anotar os dias de ofensiva.

  late int _ofensivas = 0; // vezes que o _desafio foi completado.

  final CountDownController _controller =
      CountDownController(); // controlador do Widget Circular CountDown.

  final int _duracaoTimer = 3600; // duraçao do timer em segundos.

  bool _iniciaOuPara =
      true; // booleano que define o estado do botão Start / Pause alterando a ação da função onPressed referente.

  bool _esconderBotoes = true; // booleano para esconder os botões da tela

  IconData _botaoRelogio =
      Icons.play_arrow; // altera o ícone do botão Start / Pause.

  /* Registra o objeto fornecido como um observador de ligação.
  Os observadores de ligação são notificados quando ocorrem vários eventos de aplicativo,
  por exemplo, quando a localidade do sistema é alterada. */
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  /* Cancela o registro do observador fornecido.
  Isso deve ser usado com moderação, pois é relativamente caro (O(N)
  no número de observadores registados). */
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /* Estados em que um aplicativo pode estar. */
  AppLifecycleState? _notification;

  // Detecta o estado do Circular CounDown, podendo mudar a função do botão Play / Pause.
  startStop() {
    if (_iniciaOuPara) {
      startCountDown();
    } else {
      stopCountDown();
    }
  }

  /* Inicia o Circular CountDown, altera o booleano para false e muda o ícone para Stop. */
  startCountDown() {
    setState(() {
      _iniciaOuPara = false;
      _controller.start();
      _botaoRelogio = Icons.stop;
    });
  }

  /* Pausa o Circular CountDown, altera o booleano para true e muda o ícone para Play. */
  stopCountDown() {
    setState(() {
      _iniciaOuPara = true;
      _controller.pause();
      _botaoRelogio = Icons.play_arrow;
    });
  }

  /* Detecta se o desafio já foi completado lendo
  o valor da variável _desafioCompletado.
  Se for true, o desafio foi feito.
  Se for false, o desafio precisa ser feito.
  O valor zera diariamente e escreve a contagem de ofensivas
  em outra variável. */
  verificaDesafio() {
    if (_desafioCompletado == false) {
      setState(() {
        _desafio = "Você ainda não completou o desafio diário";
      });
    } else if (_desafioCompletado == true) {
      setState(() {
        _desafio = "Você completou o desafio diário";
        _ofensivas++;
      });
    }
    return _desafio;
  }

  // ignore: unused_field
  Timer? _timer;
  int _start = 86400;

  /* Timer usado para esconder os botões do _desafio
  por 24 horas (86.400 segundos) após o mesmo ser clicado.
  Se o app for fechado pelo usuário, o Timer para e anota 
  os segundos faltantes.*/
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            _esconderBotoes = true;
            _desafioCompletado = false;
            verificaDesafio();
          });
        } else {
          setState(() {
            _esconderBotoes = false;
            _start--;
          });
        }
      },
    );
  }

  Future<void> _salvaEstadoTimer() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt('start', _start);
    });
  }

  Future<void> _leEstadoTimer() async {
    final data = await SharedPreferences.getInstance();
    setState(() {
      _start = (data.getInt('start') ?? 0);
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
              // Inicia o timer para ocultar botões e verifica se o desafio foi feito.
              onStart: () {
                startTimer();
                verificaDesafio();
              },
              // Duração do Timer em segundos
              duration: _duracaoTimer,
              // Valor inicial do Timer
              initialDuration: 0,
              // Controlador do timer
              controller: _controller,
              // Tamanho do Widget do timer
              width: MediaQuery.of(context).size.width / 1.6,
              // Height of the Countdown Widget.
              height: MediaQuery.of(context).size.height / 2,
              // Ring Color for Countdown Widget.
              ringColor: Colors.grey[300]!,
              // Ring Gradient for Countdown Widget.
              ringGradient: null,
              // Filling Color for Countdown Widget.
              fillColor: Color.fromARGB(255, 224, 9, 38),
              // Filling Gradient for Countdown Widget.
              fillGradient: null,
              // Background Color for Countdown Widget.
              backgroundColor: Colors.white,
              // Background Gradient for Countdown Widget.
              backgroundGradient: null,
              // Border Thickness of the Countdown Ring.
              strokeWidth: 22.5,
              // Begin and end contours with a flat edge and no extension.
              strokeCap: StrokeCap.round,
              // Text Style for Countdown Text.
              textStyle: const TextStyle(
                fontSize: 33.0,
                color: Color.fromARGB(255, 224, 9, 38),
                fontWeight: FontWeight.bold,
              ),
              // Format for the Countdown Text.
              textFormat: CountdownTextFormat.MM_SS,
              // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
              isReverse: true,
              // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
              isReverseAnimation: false,
              // Handles visibility of the Countdown Text.
              isTimerTextShown: true,
              // Handles the timer start.
              autoStart: false,
              onComplete: () {
                _desafioCompletado = true;
                verificaDesafio();
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _desafio,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ]),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Você possui $_ofensivas ofensivas.",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ]),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: _esconderBotoes,
                    child: Container(
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
