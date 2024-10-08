import 'package:flutter/material.dart';
import 'package:flutter_application_test/screen/home.dart';
import 'package:flutter_application_test/shared/my_app_state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const LetterLockApp());
}

class LetterLockApp extends StatelessWidget {
  const LetterLockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Trava Letras',
        home: Home(),
      ),
    );
  }
}