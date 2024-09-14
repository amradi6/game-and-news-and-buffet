import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _userName = '';

  // Getter for userName
  String get userName => _userName;

  // Setter for userName
  void setUserName(String name) {
    _userName = name;
    notifyListeners(); // Notify listeners when the state changes
  }
}