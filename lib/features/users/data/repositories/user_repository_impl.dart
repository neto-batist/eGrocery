import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_datasource.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource remoteDatasource;

  UserRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<User>> getUsers() async {
    final models = await remoteDatasource.getUsers();
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<User> getUserById(int id) async {
    final model = await remoteDatasource.getUserById(id);
    return model.toEntity();
  }

  @override
  Future<User> login(User user) async {
    final model = await remoteDatasource.login(UserModel.fromEntity(user));
    return model.toEntity();
  }

  @override
  Future<User> createUser(User user) async {
    final model = await remoteDatasource.createUser(UserModel.fromEntity(user));
    return model.toEntity();
  }

  @override
  Future<void> updateUser(User user) async {
    await remoteDatasource.updateUser(UserModel.fromEntity(user));
  }

  @override
  Future<void> deleteUser(int id) async {
    await remoteDatasource.deleteUser(id);
  }
}
