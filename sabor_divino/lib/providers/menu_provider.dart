import 'package:flutter/material.dart';

class MenuProvider with ChangeNotifier {
  String _selectedCategory = 'Todos';

  String get selectedCategory => _selectedCategory;

  void setCategory(String newCategory) {
    if (_selectedCategory != newCategory) {
      _selectedCategory = newCategory;
      notifyListeners();
    }
  }
}