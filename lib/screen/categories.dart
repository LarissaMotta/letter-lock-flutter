import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_test/screen/start.dart';

class Categories extends StatelessWidget {
  final List<String> categoriesList = [
    'Países',
    'Objetos',
    'Animais',
    'Cores',
    'Alimentos',
    'Nome',
    'Profissão',
    'Marcas'
  ];
  var intValue = Random().nextInt(8);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
        // actions: <Widget>[
        //   IconButton(
        //     icon: const Icon(Icons.add_alert),
        //     tooltip: 'Show Snackbar',
        //     onPressed: () {
        //       ScaffoldMessenger.of(context).showSnackBar(
        //           const SnackBar(content: Text('This is a snackbar')));
        //     },
        //   ),
        // ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              categoriesList[intValue],
              style: const TextStyle(fontSize: 24),
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Mudar categoria',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Implementar a mudança de categoria')));
              },
            ),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Start(category: categoriesList[intValue]),
            ),
          );
        },
        tooltip: 'Começar',
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
