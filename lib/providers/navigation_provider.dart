import 'package:flutter/material.dart';

// Provider for managing navigation state
class NavigationProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void changePage(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
