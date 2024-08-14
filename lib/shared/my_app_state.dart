import 'dart:math';

import 'package:flutter/material.dart';

class MyAppState extends ChangeNotifier {
  final List<String> categoriesList = [
    'Países', 'Objetos', 'Animais', 'Cores', 'Alimentos', 'Nome', 'Profissão', 'Marcas',
  ];
  var intValue = Random().nextInt(8);

  void regenerateValue() {
    intValue = Random().nextInt(8);
    notifyListeners();
  }

  var selectedLetter = "";

  void setLetter(String letter) {
    selectedLetter = letter;
    notifyListeners();
  }

  var selectedLetters = [];

  void selectLetter() {
    if(selectedLetter != "") {
      selectedLetters.add(selectedLetter);
      selectedLetter = "";
      notifyListeners();
    }
  }

  void clearSelectedsLetters() {
    selectedLetters = [];
    selectedLetter = "";
    regenerateValue();
  }
}