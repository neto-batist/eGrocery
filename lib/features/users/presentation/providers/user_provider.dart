import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository userRepository;

  UserProvider({required this.userRepository});

  List<User> _users = [];
  User? _currentUser;
  bool _isLoading = false;
  String? _error;

  List<User> get users => _users;
  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _error = error;
    notifyListeners();
  }

  Future<void> fetchUsers() async {
    _setLoading(true);
    _setError(null);

    try {
      _users = await userRepository.getUsers();
    } catch (e) {
      _setError(e.toString());
    }

    _setLoading(false);
  }

  Future<void> getUserById(int id) async {
    _setLoading(true);
    _setError(null);

    try {
      _currentUser = await userRepository.getUserById(id);
    } catch (e) {
      _setError(e.toString());
    }

    _setLoading(false);
  }

  Future<void> login(User user) async {
    _setLoading(true);
    _setError(null);

    try {
      _currentUser = await userRepository.login(user);
    } catch (e) {
      _setError(e.toString());
    }

    _setLoading(false);
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  Future<void> createUser(User user) async {
    _setLoading(true);
    _setError(null);

    try {
      await userRepository.createUser(user);
      await fetchUsers(); // Atualiza lista
    } catch (e) {
      _setError(e.toString());
    }

    _setLoading(false);
  }

  Future<void> updateUser(User user) async {
    _setLoading(true);
    _setError(null);

    try {
      await userRepository.updateUser(user);
      await fetchUsers(); // Atualiza lista
    } catch (e) {
      _setError(e.toString());
    }

    _setLoading(false);
  }

  Future<void> deleteUser(int id) async {
    _setLoading(true);
    _setError(null);

    try {
      await userRepository.deleteUser(id);
      await fetchUsers(); // Atualiza lista
    } catch (e) {
      _setError(e.toString());
    }

    _setLoading(false);
  }
}
