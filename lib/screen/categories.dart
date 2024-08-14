import 'package:flutter/material.dart';
import 'package:flutter_application_test/screen/start.dart';
import 'package:flutter_application_test/shared/my_app_state.dart';
import 'package:provider/provider.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              appState.categoriesList[appState.intValue],
              style: const TextStyle(fontSize: 24),
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Mudar categoria',
              onPressed: () {
                appState.regenerateValue();
              },
            ),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Start(),
            ),
          );
        },
        tooltip: 'Começar',
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
