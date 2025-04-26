import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository userRepository;

  UserViewModel({required this.userRepository});

  List<User> _users = [];
  User? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  List<User> get users => _users;
  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  Future<void> fetchAllUsers() async {
    _setLoading(true);
    try {
      _users = await userRepository.getUsers();
      _setError(null);
    } catch (e) {
      _setError(e.toString());
    }
    _setLoading(false);
  }

  Future<void> fetchUserById(int id) async {
    _setLoading(true);
    try {
      _currentUser = await userRepository.getUserById(id);
      _setError(null);
    } catch (e) {
      _setError(e.toString());
    }
    _setLoading(false);
  }

  Future<void> createUser(User user) async {
    _setLoading(true);
    try {
      await userRepository.createUser(user);
      await fetchAllUsers(); // Atualiza lista após criação
      _setError(null);
    } catch (e) {
      _setError(e.toString());
    }
    _setLoading(false);
  }

  Future<void> updateUser(User user) async {
    _setLoading(true);
    try {
      await userRepository.updateUser(user);
      await fetchAllUsers(); // Atualiza lista após edição
      _setError(null);
    } catch (e) {
      _setError(e.toString());
    }
    _setLoading(false);
  }

  Future<void> deleteUser(int id) async {
    _setLoading(true);
    try {
      await userRepository.deleteUser(id);
      await fetchAllUsers(); // Atualiza lista após exclusão
      _setError(null);
    } catch (e) {
      _setError(e.toString());
    }
    _setLoading(false);
  }

  Future<void> login(User user) async {
    _setLoading(true);
    try {
      _currentUser = await userRepository.login(user);
      _setError(null);
    } catch (e) {
      _setError(e.toString());
    }
    _setLoading(false);
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
