import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_test/shared/my_app_state.dart';
import 'package:provider/provider.dart';

class Start extends StatelessWidget {
  final List<String> alphabetTop = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
  ];
  final List<String> alphabetBottom = [
    'l',
    'm',
    'n',
    'o',
    'p',
    'r',
    's',
    't',
    'u',
    'v',
  ];

  Start({super.key});
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(appState.categoriesList[appState.intValue]),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height-
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GridOfButtons(alphabet: alphabetTop),
              const ButtonsStop(),
              GridOfButtons(alphabet: alphabetBottom),
            ],
          ),
        ),
      ),
    );
  }
}

class GridOfButtons extends StatelessWidget {
  const GridOfButtons({super.key, required this.alphabet});
  final List<String> alphabet;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Container(
      constraints: const BoxConstraints(
        minHeight: 100, // Largura mínima
        maxHeight: 250, // Largura máxima
      ),
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5, // 5 columns
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 1, // Ensure that each cell is a square
        ),
        itemCount: 10, // 2 rows * 5 columns = 10 buttons
        itemBuilder: (context, index) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: appState.selectedLetter == alphabet[index]
                    ? Colors.red
                    : const Color.fromARGB(
                        189, 112, 63, 148), // Cor de fundo do botão,
                minimumSize: const Size(50, 50),
                maximumSize: const Size(200, 100)),
            onPressed: !appState.selectedLetters.contains(alphabet[index])
                ? () {
                    appState.setLetter(alphabet[index]);
                  }
                : null,
            child: Text(
              alphabet[index].toUpperCase(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}

class ButtonsStop extends StatefulWidget {
  const ButtonsStop({super.key});

  @override
  State<ButtonsStop> createState() => _ButtonsStopState();
}

class _ButtonsStopState extends State<ButtonsStop> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isButtonDisabled = false;
  int _remainingTime = 10;
  Timer? _timer;
  bool gameOver = false;

  void _startTimer(BuildContext context, MyAppState appState) {
    setState(() {
      _isButtonDisabled = true;
      _remainingTime = 10;
    });
    _startTimerSound();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer?.cancel();
          _isButtonDisabled = false;
          appState.clearSelectedsLetters();
          _gameOverSound();
          showGameOverModal(context);
        }
      });
    });
  }

  void _restartTimer(BuildContext context, MyAppState appState) {
    _timer?.cancel();
    _startTimer(context, appState);
  }

  void _startTimerSound() async {
    await _audioPlayer.play('assets/effects/timer-click-track.mp3');
  }

  void _gameOverSound() {
    gameOver = true;
    _audioPlayer.play('assets/effects/alarm-clock.mp3');
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          width: 100,
          height: 100,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red, // Cor de fundo do botão
            ),
            onPressed: ()  {
              if (appState.selectedLetter != "") {
                appState.selectLetter();
                if(appState.selectedLetters.length == 20) {
                  _audioPlayer.stop();
                  appState.clearSelectedsLetters();
                  _timer?.cancel();
                 showEndRoundModal(context);
                }
                else {
                  (_isButtonDisabled ? _restartTimer(context, appState) : _startTimer(context, appState));
                }
              }
            },
            child: Text(
              '$_remainingTime s',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
          ),
        ),
      ]),
    );
  }

  Future<dynamic> showGameOverModal(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('GAME OVER'),
          content: const Text(
              'Você perdeu o jogo! Deseja escolher outra categoria ou voltar para o início?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Próxima categoria'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Inicio'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                // SystemNavigator.pop();
              },
            ),
          ],
        );
      },
    );
  }
}

  Future<dynamic> showEndRoundModal(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('RODADA FINALIZADA'),
          content: const Text(
              'Deseja jogar novamente ou sair?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Próxima categoria'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Inicio'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
