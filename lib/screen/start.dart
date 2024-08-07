import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Start extends StatelessWidget {
  Start({required this.category});
  final String category;

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
    'j'
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
    'v'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('NOME DA CATEGORIA'),
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
                height: 600,
                child: Column(children: [
                  GridOfButtons(alphabet: alphabetTop),
                  ButtonsStop(),
                  GridOfButtons(alphabet: alphabetBottom),
                ]))));
  }
}

class GridOfButtons extends StatelessWidget {
  GridOfButtons({required this.alphabet});
  final List<String> alphabet;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
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
                primary: Color.fromARGB(189, 112, 63, 148), // Cor de fundo do botão
              ),
            onPressed: () {
              // Define button action here
              print('Button ${alphabet[index + 1]} pressed');
            },
            child: Text(alphabet[index].toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),),
          );
        },
      ),
    );
  }
}

class ButtonsStop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(32.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        IconButton(
          icon: Icon(Icons.pause),
          tooltip: 'Show Snackbar',
          onPressed: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Pause button')));
          },
        ),
        SizedBox(
            width: 100,
            height: 100,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // Cor de fundo do botão
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Click button')));
              },
              child: const Text('10s', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),),
            )),
        IconButton(
          icon: const Icon(Icons.refresh),
          tooltip: 'Show Snackbar',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Iniciar novamente')));
          },
        ),
      ]),
    );
  }
}
