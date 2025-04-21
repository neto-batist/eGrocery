import 'package:flutter/material.dart';
import '../providers/user_provider.dart';
import '../../domain/entities/user.dart';

class UserController {
  final UserProvider _userProvider;

  UserController(this._userProvider);

  // Acesso à lista de usuários
  List<User> get users => _userProvider.users;

  // Usuário logado
  User? get currentUser => _userProvider.currentUser;

  // Estado de loading e erro
  bool get isLoading => _userProvider.isLoading;
  String? get error => _userProvider.error;

  // Ações
  Future<void> fetchUsers() => _userProvider.fetchUsers();

  Future<void> getUserById(int id) => _userProvider.getUserById(id);

  Future<void> login(User user) => _userProvider.login(user);

  void logout() => _userProvider.logout();

  Future<void> createUser(User user) => _userProvider.createUser(user);

  Future<void> updateUser(User user) => _userProvider.updateUser(user);

  Future<void> deleteUser(int id) => _userProvider.deleteUser(id);
}
