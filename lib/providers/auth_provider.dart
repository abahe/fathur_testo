import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> login(String username, String password) async {
    // Validasi form
    if (username.isEmpty || password.length < 6) {
      throw Exception('Username tidak boleh kosong dan password minimal 6 karakter');
    }

    // Simulasikan login sukses
    await Future.delayed(Duration(seconds: 1));
    _isLoggedIn = true;
    notifyListeners();

    // Simpan session
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    print("Login successful: $_isLoggedIn");
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    print("Login status checked: $_isLoggedIn"); // Debug log
    notifyListeners();
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
  }
}