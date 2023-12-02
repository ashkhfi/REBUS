import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User? _loggedInUser;

  User? get loggedInUser => _loggedInUser;

  void loginUser(User user) {
    _loggedInUser = user;
    notifyListeners();
  }

  void logoutUser() {
    _loggedInUser = null;
    notifyListeners();
  }
}
