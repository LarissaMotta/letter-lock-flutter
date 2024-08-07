import 'package:flutter/material.dart';
import 'package:flutter_application_test/screen/home.dart';

void main() {
  runApp(LetterLockApp());
}

class LetterLockApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trava Letras',
      home: Home(),
    );
  }
}
