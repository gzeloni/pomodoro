// ignore_for_file: prefer_const_constructors
// dependências usadas no programa.
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  // declaração de variáveis
  late int _duracaoTimer = 1500; // duraçao do timer em segundos.
  late int _voltas = 0; // contagem de voltas de 25 minutos do usuário.
  final CountDownController _controller =
      CountDownController(); // controlador do Widget Circular CountDown.
  bool iniciaOuPara =
      true; // booleano que define o estado do botão Start / Pause alterando a ação da função onPressed referente.
  IconData _botaoRelogio =
      Icons.play_arrow; // altera o ícone do botão Start / Pause.
  /* Lê os saves do aplicativo na inicialização para
  definir a quantidade atual de voltas de 25 minutos e atual estado do timer
  caso o app sofra um encerramento inesperado. */
  Future<void> readData() async {
    final data = await SharedPreferences.getInstance();
    setState(() {
      _voltas = (data.getInt('counter') ??
          0); // corrige a variável se valor for igual a zero. se não houver dados, mantém como está.
      _duracaoTimer = (data.getInt('duracaoTimer') ?? 0); // ...
    });
  }

  /* Registra o objeto fornecido como um observador de ligação.
  Os observadores de ligação são notificados quando ocorrem vários eventos de aplicativo,
  por exemplo, quando a localidade do sistema é alterada. */
  @override
  void initState() {
    super.initState();
    readData();
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
  AppLifecycleState? _notificacao;

  // Detecta o estado do Circular CounDown, podendo mudar a função do botão Play / Pause.
  startStop() {
    if (iniciaOuPara) {
      startCountDown();
    } else {
      stopCountDown();
    }
  }

  /* Inicia o Circular CountDown, altera o booleano para false e muda o ícone para Stop. */
  startCountDown() {
    setState(() {
      iniciaOuPara = false;
      _controller.start();
      _botaoRelogio = Icons.stop;
    });
  }

  /* Pausa o Circular CountDown, altera o booleano para true e muda o ícone para Play. */
  stopCountDown() {
    setState(() {
      iniciaOuPara = true;
      _controller.pause();
      _botaoRelogio = Icons.play_arrow;
    });
  }

  /* Salva a quantidade de voltas de 25 minutos. */
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
