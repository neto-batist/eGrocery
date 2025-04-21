import '../entities/user.dart';

abstract class UserRepository {
  Future<List<User>> getUsers();
  Future<User> getUserById(int id);
  Future<User> login(User user);
  Future<void> createUser(User user);
  Future<void> updateUser(User user);
  Future<void> deleteUser(int id);
}
