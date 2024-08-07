import 'package:flutter/material.dart';
import 'package:flutter_application_test/screen/categories.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TRAVA LETRAS'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Uma maneira diferente de se jogar o famoso "STOP" junto com seus amigos e familiares',
            textAlign: TextAlign.center,
          )
        )
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Categories(),
            ),
          );
        },
        tooltip: 'Iniciar jogo',
        child: const Text('Iniciar'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
