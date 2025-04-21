import '../models/user_model.dart';

abstract class UserRemoteDatasource {
  Future<List<UserModel>> getUsers(); // Retorna a lista de usuários do servidor
  Future<UserModel> getUserById(int id); // Busca um usuário específico
  Future<UserModel> login(UserModel user); // Faz login com e-mail e senha
  Future<void> createUser(UserModel user); // Cria um novo usuário
  Future<void> updateUser(UserModel user); // Atualiza um usuário existente
  Future<void> deleteUser(int id); // Exclui um usuário por ID
}
