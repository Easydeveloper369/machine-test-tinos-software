import 'package:flutter/material.dart';
import '../services/database_service.dart';

class AuthProvider extends ChangeNotifier {
  final DatabaseService databaseService = DatabaseService();

  bool loggedIn = false;

  Future<void> checkLogin() async {
    loggedIn = await databaseService.isLoggedIn();
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      return false;
    }

    await databaseService.saveLogin();

    loggedIn = true;
    notifyListeners();

    return true;
  }

  Future<void> logout() async {
    await databaseService.logout();
    loggedIn = false;
    notifyListeners();
  }
}