import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class UserProvider with ChangeNotifier {
  final ApiService _apiService = ApiService(); // Gunakan Dio
  List<User> _users = [];
  bool _isLoading = false;

  List<User> get users => _users;
  bool get isLoading => _isLoading;

  UserProvider() {
    fetchUsers(); // Auto-fetch saat provider diinisialisasi
  }

  Future<void> fetchUsers() async {
    _isLoading = true;
    notifyListeners();

    try {
      _users = await _apiService.fetchUsers();
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}